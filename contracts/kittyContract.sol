// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

import "./IERC721.sol";

contract kittyContract is IERC721{

    string public constant tokenName = "MargaritaKitties";
    string public constant tokenSymbol = "MK";
    

    struct Kitty{
        uint256 genes;
        uint64 birthTime;
        uint32 mumId;
        uint32 dadId;
        uint16 generation;
    }

    Kitty[] kitties;


    mapping(address => uint256) ownershipTokenCount;

    mapping (uint256 => address) public kittyIndexToOwner;


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
    }

emit Transfer(_from, _to, _tokenId);
}

function _owns(address _claimant, uint256 _tokenId) internal view returns(bool){
    return kittyIndexToOwner[_tokenId]==_claimant;
}
}