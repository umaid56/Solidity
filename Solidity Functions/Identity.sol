// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract Identuty{
    string name;
    uint age;
    
    constructor(){
        name = 'Umaid';
        age = 21;
    }
    function Rollno() public pure returns(uint){                    // FOR READ LOCAL VARIABLE
        uint roll = 1;
        return roll;
    } 
    function Name() view public returns(string memory){            // FOR READ STATE/LOCAL VARAIBLE
         return name;   
        }
    function Age() view public returns(uint){
        return age;
    }
}