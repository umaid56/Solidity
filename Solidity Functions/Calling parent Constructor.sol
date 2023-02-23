// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract A{
    string public text;
    constructor(string memory _text){
        text = _text;
    }
}

contract B{
    string public name;
    constructor(string memory _name){
        name=_name;
    }
}

contract C is A("a"),B("b") {                                                       //Statically initialize the parameters
}

contract D is A,B{
    constructor(string memory _text, string memory _name) A(_text)  B(_name){       //Dynamically initialize the parameters 

    } 
}

contract D0 is A("a"),B{
    constructor(string memory _name) B(_name){       //both Statically & Dynamically initialize the parameters 


    } 
}



