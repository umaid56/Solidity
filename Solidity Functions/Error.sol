// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract error{
    uint public num = 123;

    function requires(uint i) pure public{
        require(i<10,'I is greate');
    }
    function testrevert(uint i) pure public{
        if(i<10)
            if(i<2)
                if(i<0)
                    revert( 'I is greate than 0');    
    }
    function testassert() view public{
        assert(num == 123);

    }
}