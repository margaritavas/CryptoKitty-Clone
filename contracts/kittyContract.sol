// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

import "./Ownable.sol";
import "./IERC721.sol";
import "./IERC721Receiver.sol";

contract kittyContract is IERC721, Ownable {
    
    uint256 public constant CREATION_LIMIT_GEN0=10;
    string public constant tokenName = "MargaritaKitties";
    string public constant tokenSymbol = "MK";

    bytes4 internal constant MAGIC_ERC721_RECEIVED = bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
    bytes4 private constant __INTERFACE_TO_ERC721 = 0x80ac58cd;
    bytes4 private constant __INTERFACE_TO_ERC165 = 0x01ffc9a7;


    uint256 public gen0Counter;
    
    event Birth(
        address owner,
        uint256 newKittenId,
        uint256 mumId,
        uint256 dadId,
        uint256 genes
    );
    
    struct Kitty{
        uint256 genes;
        uint64 birthTime;
        uint32 mumId;
        uint32 dadId;
        uint16 generation;
    }

    Kitty[] kitties;

    mapping (address => uint256) ownershipTokenCount;
    mapping (uint256 => address) public kittyIndexToOwner;
    mapping (uint256 => address) public kittyIndexToApproved;
    mapping (address => mapping(address => bool)) private _operatorApprovals;

function supportsInterface( bytes4 _interfaceId) external pure returns (bool){
    return (_interfaceId == __INTERFACE_TO_ERC165 || _interfaceId == __INTERFACE_TO_ERC721);
}

function breed(uint256 _mumId, uint256 _dadId) public {
    require(_owns(msg.sender, _mumId), "The user does not own the token");
    require(_owns(msg.sender, _dadId), "The user does not own the token");

    (uint256 dadDna,,,,uint256 DadGeneration) = getKitty(_dadId);
    (uint256 mumDna,,,,uint256 MumGeneration) = getKitty(_mumId);
    uint256 newDna = _mixDna(dadDna, mumDna);

    uint256 kidGen = 0;

    if (DadGeneration < MumGeneration){
        kidGen = MumGeneration + 1;
        kidGen /=2;
    } else if (DadGeneration > MumGeneration){
        kidGen = DadGeneration + 1;
        kidGen /=2;
    } else{
        kidGen = MumGeneration + 1;
    }

    _createKitty(_mumId, _dadId, kidGen, newDna, msg.sender);
}

function createKittyGen0(uint256 _genes) public onlyOwner returns(uint256){
    require(gen0Counter< CREATION_LIMIT_GEN0);

    gen0Counter++;

    return _createKitty(0, 0, _genes, 0, msg.sender);

}

function getKitty(uint256 _tokenId) public view returns(
        uint256 genes, 
        uint256 birthTime, 
        uint256 mumId, 
        uint256 dadId, 
        uint256 generation){

            Kitty storage kitty = kitties[_tokenId];

        birthTime = uint256(kitty.birthTime);
        mumId = uint256(kitty.mumId);
        dadId = uint256(kitty.dadId);
        generation = uint256(kitty.generation);
        genes = kitty.genes;
}

function _createKitty(
    uint256 _mumId,
    uint256 _dadId,
    uint256 _genes,
    uint256 _generation,
    address _owner
) private returns (uint256){
    Kitty memory _kitty = Kitty({
        genes: _genes,
        birthTime: uint64(block.timestamp),
        mumId: uint32(_mumId),
        dadId: uint32(_dadId),
        generation: uint16(_generation)
    });

    kitties.push(_kitty);

    uint256 newKittenId = kitties.length -1;

    emit Birth(_owner, newKittenId, _mumId, _dadId, _genes);

    _transfer(address(0), _owner, newKittenId);

    return newKittenId;
}


function balanceOf(address owner) public view override returns (uint256){
    return ownershipTokenCount[owner];
}

function totalSupply() public view override returns (uint256){
    return kitties.length;
}

function name() external pure override returns (string memory){
    return tokenName;
}

function symbol() external pure override returns (string memory){
    return tokenSymbol;
}

function ownerOf(uint256 _tokenId) external view override returns (address){
    return kittyIndexToOwner[_tokenId];
}


function _safeTransfer(address _from, address _to, uint256 _tokenId, bytes memory _data) internal{
    _transfer(_from, _to, _tokenId);
    require(_checkERC721Support(_from, _to, _tokenId, _data));

}

function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata _data) override external{
    require(_owns(_from, _tokenId));
    require(_to != address(0));
    require(_tokenId < kitties.length);
    require(msg.sender == _from || _approvedFor(msg.sender, _tokenId) || isApprovedForAll(_from, msg.sender));

    _safeTransfer(_from, _to, _tokenId, _data );
}

function safeTransferFrom(address _from, address _to, uint256 _tokenId) override external{
    _safeTransfer(_from, _to, _tokenId, "");
}


function transferFrom(address _from, address _to, uint256 _tokenId) override public {
    require(_owns(_from, _tokenId));
    require(_to != address(0));
    require(_tokenId < kitties.length);
    require(msg.sender == _from || _approvedFor(msg.sender, _tokenId) || isApprovedForAll(_from, msg.sender));

    _transfer(msg.sender, _to, _tokenId);
}


function transfer(address _to, uint256 _tokenId) public override {
    require (_to != address(0), "ERC721: invalid address");
    require (_to != address(this), "ERC721: cannot transfer to yourself");
    require (_owns(msg.sender,_tokenId), "ERC721: you do not own this token");

    _transfer(msg.sender, _to, _tokenId);
}

function _transfer(address _from, address _to, uint256 _tokenId) internal {
    ownershipTokenCount[_to]++;
    kittyIndexToOwner[_tokenId] = _to;

    if(_from != address(0)){
        ownershipTokenCount[_from]--;
        delete kittyIndexToApproved[_tokenId];
    }

emit Transfer(_from, _to, _tokenId);
}

function approve(address _approved, uint256 _tokenId) override public {
    require (_owns(msg.sender, _tokenId), "ERC721: you do not own this token");
    
    _approve(_approved, _tokenId);
    emit Approval(msg.sender, _approved, _tokenId);
}

function setApprovalForAll(address _operator, bool approved) override external{
    require (_operator != msg.sender);

    _setApprovalForAll(_operator, approved);
    emit ApprovalForAll(msg.sender, _operator, approved);
}

function _setApprovalForAll(address _operator, bool approved) internal{
_operatorApprovals[msg.sender][_operator] = approved;
}

function getApproved(uint256 _tokenId) external view override returns (address){
    require (_tokenId < kitties.length); //Token must exist;

    return kittyIndexToApproved[_tokenId];
}

function isApprovedForAll(address _owner, address _operator) public view override returns (bool){
    return _operatorApprovals[_owner][_operator];
}

function _approve(address _approved, uint256 _tokenId) internal{
    kittyIndexToApproved[_tokenId] = _approved;
}

function _owns(address _claimant, uint256 _tokenId) internal view returns(bool){
    return kittyIndexToOwner[_tokenId]==_claimant;
}
function _approvedFor(address _claimant, uint256 _tokenId) internal view returns(bool){
    return kittyIndexToApproved[_tokenId]==_claimant;
    }

function _checkERC721Support(address _from, address _to, uint256 _tokenId, bytes memory _data) internal returns(bool){
    if(!_isContract(_to)){
        return true;
    }
    bytes4 returnData = IERC721Receiver(_to).onERC721Received(msg.sender, _from, _tokenId, _data);
    return returnData == MAGIC_ERC721_RECEIVED;
}

function _isContract(address _to) view internal returns(bool){
    uint32 size;
    assembly{
        size := extcodesize(_to)
    }
    return size > 0;
}

function _mixDna(uint256 _mumId, uint256 _dadId) internal pure returns(uint256){
    uint256 firstHalf = _mumId / 100000000;
    uint256 secondHalf = _dadId % 100000000;

    uint256 newDna = firstHalf * 100000000;
    newDna = newDna + secondHalf;

    return newDna;
}

function tokensOfOwner(address _owner) public view returns(uint256[] memory ownerTokens) {
    uint256 tokenCount = balanceOf(_owner);

    if (tokenCount == 0) {
        return new uint256[](0);
    } else {
        uint256[] memory result = new uint256[](tokenCount);
        uint256 totalCats = totalSupply();
        uint256 resultIndex = 0;

        uint256 catId;

        for (catId = 1; catId <= totalCats; catId++) {
            if (kittyIndexToOwner[catId] == _owner) {
                result[resultIndex] = catId;
                resultIndex++;
            }
        }

        return result;
    }

}
