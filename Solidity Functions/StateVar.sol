// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.5.0 <0.9.0;

contract state{
    string public name;
    uint public age;

    function setage() public{
        name = 'Umaid';
        age = 10;
    }


}