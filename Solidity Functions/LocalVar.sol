// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 < 0.9.0;

contract Local{
     string  name = 'Umaid';                                            //state Variable
    function Data() pure public returns(uint){
       
        uint age =21;                                                   //Local Variable
        return age;                                 
    }
}