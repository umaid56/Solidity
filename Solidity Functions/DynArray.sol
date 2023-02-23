// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract array{
    uint [] public arr;
    function pushElement(uint items) public{
        arr.push(items);
    } 
    function length() view public returns(uint){
        return arr.length;
    }   
    function popElement() public{
        arr.pop();
    }
}