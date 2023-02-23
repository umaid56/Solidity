// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

contract A{

    function F1() public pure returns(uint){      
        return 1;
    }
    function F2() private pure returns(uint){
        return 2;
    }
    function F3() internal pure returns(uint){
        return 3;
    }
    function F4() external pure returns(uint){
        return 4;
    }
}
contract B is A{
    uint public ax=F1();
   //  uint public bx=F2();
      uint public cx=F3();
}
contract C{
    A obj = new  A();
    uint public c= obj.F4();
}