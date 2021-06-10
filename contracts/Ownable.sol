// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

contract Ownable{

    address public owner;

modifier onlyOwner(){
    require(msg.sender == owner);
    _;
}

constructor(){
    owner = msg.sender;
}
}