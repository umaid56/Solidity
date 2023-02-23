// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract pay{

    address payable user = payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
    address public owner;
    constructor(){
        owner = msg.sender;
    }
    function PayEth() public payable{

    }
    function getbalance() view public returns(uint){
       return address(this).balance;
    }

    function sendEth() public{
        user.transfer(1 ether); 
    }
    function Withdraw(uint amount) public{
        require(msg.sender == owner, "No Owner");
        payable(msg.sender).transfer(amount);
    }
}

