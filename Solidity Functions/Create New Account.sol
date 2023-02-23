// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract Account{
    address public bank;
    address public value;

    constructor(address _value) payable {
        bank = msg.sender;
        value = _value;
    }
}

contract New_Account{

    Account[] public accounts;
    function create_Account(address _owner) external payable {
        Account account = new Account{value : 111}( _owner);
        accounts.push(account);
    }
}