// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract Bank{
        event Deposit(uint amount);
        event Withdraw(uint amount);

        address public owner = msg.sender;

    receive() external payable{
        emit Deposit(msg.value);
    }

    function withdraw() external{
        require(msg.sender == owner , "Not Owner");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
}