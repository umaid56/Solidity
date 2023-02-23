// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 < 0.9.0;

contract Lottery{
    address public Owner;
    address payable[] public Participant;

    constructor(){
        Owner= msg.sender;

    }
    receive() external payable{
        require(msg.value== 1 ether);
        Participant.push(payable(msg.sender));
    }
    function GetBalance()public view returns(uint){
        require(msg.sender== Owner,"Only Owner can check");
        return address(this).balance;
    }
    function random()public view returns(uint){
       require(msg.sender==Owner,"Only Owner");   
    return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,Participant.length)));
    }
    function selectwinner()public {
        require(msg.sender== Owner);
        require(Participant.length>=3);
        uint r= random();
        address payable winner;
        uint index = r % Participant.length;
        winner = Participant[index];
        winner.transfer(GetBalance());
        Participant = new address payable[](0);

    }
} 