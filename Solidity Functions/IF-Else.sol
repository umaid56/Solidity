// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract Condition{

    function check(uint a) pure public returns(string memory){
        string memory value;
        if(a>0)
        value ="A is greater";
        else if(a<0)
        value="A is Less";
        else{
            value="Equal to Zero";
        }
        return value;
    }
}