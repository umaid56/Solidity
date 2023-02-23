// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.3;

contract Fallback {
    event log(string func, address sender, uint value, uint data);

    fallback() external payable{
         emit log("fallback", msg.sender, msg.value,msg.data);
    }
    receive() external payable{
         emit log("receive", msg.sender, msg.value,msg.data);
    }
}