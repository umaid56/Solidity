// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract Byt{
    bytes public b3;
    bytes public b2;

    function set() public{
        b3='abc';
        b2 = 'cd';
    }
}