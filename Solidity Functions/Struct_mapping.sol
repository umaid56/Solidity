// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract mapp{

    struct Student{
    string name;
    uint class; 
}
    mapping(uint => Student ) public data;

    function set(uint _rn, string memory _name, uint _class) public{
     data[_rn]= Student(_name , _class); 
    }
}