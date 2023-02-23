//SPDX-License-Identifier : UNLICENSED
pragma solidity 0.8.3;

import "hardhat/console.sol";

contract Token{
         string public name="Hardhat";
         string public symbol= "HD";
         uint public totalsupply=1000;

         address public owner;
         mapping(address => uint) balances;

    constructor(){
        owner = msg.sender;
        balances[msg.sender]=totalsupply;
    }


    function transfer(address to, uint amount) external{
     console.log("Sender sending tokens", balances[msg.sender]);               //debugging
     console.log("sender balances in ", amount , to);                           //debugging
        require(balances[msg.sender] >= amount,"Not enough balances");
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function CheckBalance(address res) external view returns(uint){
        return balances[res];
    }

}