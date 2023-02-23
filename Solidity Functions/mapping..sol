// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract mapp{
    mapping(uint => string) public student;
    function set(uint rn, string memory name) public{
        student[rn] = name;
    }
    

}