// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract callingContract{

    function getvalue(TestContract addresss, uint _id) external{
        addresss.getvalue(_id);    
    }
    function CheckValue(address test) external view returns(uint _id){
        _id = TestContract(test).CheckValue();
    }
    function sendether(TestContract addresss, uint _id) external{
        addresss.getvalue(_id);    
    }
    function checkether(address test) external view returns(uint _id){
        _id = TestContract(test).CheckValue();
    }
}


contract TestContract{

    uint public id;
    uint public value = 123;

    function getvalue(uint _id) external{
        id = _id;
    }    

    function CheckValue() external view returns(uint){
        return id;
    }

    function sendEther(uint _id) external payable {
        id = _id;
        value=msg.value;
    }

    function checkEther() external view returns(uint,uint){
        return (id, value);
    }
}