// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract ID{
    string public name;
    uint public age;
    constructor(string memory _name ,uint _age ){
        name = _name;
        age = _age;
    }
}