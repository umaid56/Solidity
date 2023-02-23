// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract Kill{
    constructor () payable{

    }
    function kill() external{
            selfdestruct(payable(msg.sender));
    }

    function OnClick() pure external returns(string memory){
        return "Deleted.....!";
    }
}

contract Helper{
    function getBalance() external view returns(uint){
        return address(this).balance;
    }
    function kill(Kill _kill) external{
        _kill.kill();
    }
}