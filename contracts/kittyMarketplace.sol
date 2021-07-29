// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

import "./kittyContract.sol";
import "./Ownable.sol";


contract KittyMarketplace is Ownable {

    kittyContract private _kittyContract;

    struct Offer{
        address payable seller;
        uint256 price;
        uint256 index;
        uint256 tokenId;
        bool active;
    }

    Offer[] offers;

    event MarketTransaction(string TxType, address owner, uint256 tokenId);

    mapping(uint256 => Offer) tokenIdToOffer;

    function setkittyContract(address _kittyContractAddress) public onlyOwner{
        _kittyContract = kittyContract(_kittyContractAddress);
    }

    constructor(address _kittyContractAddress) public {
        setkittyContract(_kittyContractAddress);
    }

    function getOffer(uint256 _tokenId) external view returns ( address seller, uint256 price, uint256 index, uint256 tokenId, bool active){
        Offer storage offer = tokenIdToOffer[_tokenId];
        return(
            offer.seller,
            offer.price,
            offer.index,
            offer.tokenId,
            offer.active
        );
    }

    function getAllTokenOnSale() external view  returns(uint256[] memory listOfOffers){
        uint256 totalOffers = offers.length;

        if(totalOffers == 0){
            return new uint256[](0);
        } else{
            uint256[] memory result = new uint256[](totalOffers);

            uint256 offerId;

            for(offerId = 0; offerId<totalOffers; offerId++){
                if(offers[offerId].active == true){
                    result[offerId] = offers[offerId].tokenId;
                }
            }

            return result;
        }

    }

    function _ownsKitty(address _address, uint256 _tokenId) internal view returns(bool){
        return (_kittyContract.ownerOf(_tokenId)==_address);
    }

    function setOffer(uint256 _price, uint256 _tokenId) public{
        require(_ownsKitty(msg.sender, _tokenId), "You are not the owner of that kitty");
        require(tokenIdToOffer[_tokenId].active == false, "Yo can not sell twice the same offers");
        require(_kittyContract.isApprovedForAll(msg.sender, address(this)), "Contract needs to be approved to tranfer the kitty in future");

    Offer memory _offer = Offer({
        seller: payable(msg.sender),
        price: _price,
        active: true,
        tokenId: _tokenId,
        index: offers.length
    });

    tokenIdToOffer[_tokenId]=_offer;
    offers.push(_offer);

    emit MarketTransaction("Create offer", msg.sender, _tokenId);
    }
    function removeOffer(uint256 _tokenId) public{
        Offer memory offer = tokenIdToOffer[_tokenId];
        require(offer.seller == msg.sender, "You are not the seller of this kitty");

    delete tokenIdToOffer[_tokenId];
    offers[offer.index].active = false;

    emit MarketTransaction("Remove offer", msg.sender, _tokenId);

    }
    function buyKitty(uint256 _tokenId) public payable{

        Offer memory offer = tokenIdToOffer[_tokenId];
        require(msg.value == offer.price, "The price is incorrect");
        require(tokenIdToOffer[_tokenId].active == true, "No active order present");

        //Important: delete the kitty from the mapping BEFORE paying out in order to prevent re-entrancy
        delete tokenIdToOffer[_tokenId];
        offers[tokenIdToOffer[_tokenId].index].active == false;

        // Transfer funds to the seller

        if (offer.price>0){
            offer.seller.transfer(offer.price);
        }

        //Transfer ownership

        _kittyContract.transferFrom(offer.seller, msg.sender, _tokenId);

        emit MarketTransaction("Buy", msg.sender, _tokenId);

    }
}