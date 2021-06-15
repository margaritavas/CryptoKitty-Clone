// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

import "./Ownable.sol";
import "./IERC721.sol";

contract kittyContract is IERC721, Ownable {

    string public constant tokenName = "MargaritaKitties";
    string public constant tokenSymbol = "MK";

    uint256 public constant CREATION_LIMIT_GEN0=10;

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

function createKittyGen0(uint256 _genes) public onlyOwner returns(uint256){
    require(gen0Counter< CREATION_LIMIT_GEN0);

    gen0Counter++;

    return _createKitty(0, 0, _genes, 0, msg.sender);

}

function getKitty(uint256 _tokenId) external view returns(
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


function balanceOf(address owner) external view override returns (uint256){
    return ownershipTokenCount[owner];
}

function totalSupply() external view override returns (uint256){
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

function transfer(address _to, uint256 _tokenId) external override {
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

function _owns(address _claimant, uint256 _tokenId) internal view returns(bool){
    return kittyIndexToOwner[_tokenId]==_claimant;
}

function approve(address _approved, uint256 _tokenId) override public {
    require (_owns(msg.sender, _tokenId), "ERC721: you do not own this token");
    
    _approve(_approved, _tokenId);
    emit Approval(msg.sender, _approved, _tokenId);
}

function _approve(address _approved, uint256 _tokenId) internal{
    kittyIndexToApproved[_tokenId] = _approved;
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

function isApprovedForAll(address _owner, address _operator) external view override returns (bool){
    return _operatorApprovals[_owner][_operator];
}
}