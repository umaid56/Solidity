 // SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract functions{
    string public name = 'Umaid';                   //also used public instead of getter function
    uint age =21;

    function get() public view returns(uint){       // To return value without modify
    return age;
    }
    function set(uint newage) public{               //return value after modify
        age= newage;   
    }
}