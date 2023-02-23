// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract array{

    bytes public b1 ='abc';

    function changed() public{
        b1.push('b');
    }
    function element(uint a) public view returns(bytes1){
        return b1[a];

    }
    function length()  public view returns(uint){
        return b1.length;
    }

    //delete nums[1]
    //nums.push
    //nums.pop  

}