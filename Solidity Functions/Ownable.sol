// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract Ownable{

    address public owner;
    constructor(){
        owner = msg.sender;
    }
    modifier OnlyOwner(){
        require(msg.sender == owner, "not Owner");
        _;
    }

    function ChangeOwner(address new_owner) public OnlyOwner{
        require(new_owner !=address(0) , "Invalid Address");
        owner = new_owner;
    }

}