// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract A{
    event Log(string text);
    function foo() public virtual{
        emit Log("A.foo");
    }
    function bar() public virtual{
        emit Log("A.bar");
    }
}
contract B is A{
    function foo() public virtual override{
        emit Log("B.foo");
        A.foo();                                    //Directly call the Parent Function
        }
    function bar() public virtual override{
        emit Log("B.bar");                          //Using Super Keyword call the parent function
        super.bar();
        }
    }
contract C is A{
    function foo() public virtual override{
        emit Log("C.foo");
        A.foo();                                    //Directly call the Parent Function
        }
    function bar() public virtual override{
        emit Log("C.bar");                          //Using Super Keyword call the parent function
        super.bar();
        }
    }
    
contract D is B, C{
    function foo() public override(B,C){
        B.foo();
    }
    function bar() public override(B,C)
    {
        super.bar();
    }
}