// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract global{

    function get() public view  returns(uint block_no, uint timestamp, address msgSender){
        return(block.number, block.timestamp, msg.sender);
    }
}