// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract Condition{
    bool public value;

    function check(uint a) public returns(bool){
        if(a>10)
        {
        value = true;
        return value;
        }
        else
        {
            value = false;
            return value;
        }

    }
}