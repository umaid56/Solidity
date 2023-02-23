// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

struct Student{
    uint rn;
    string name;
}
    contract Str{
        Student public s1;
        constructor(uint _rn, string memory _name){
            s1.rn = _rn;
            s1.name = _name;
        }
    function Changed(uint _rn, string memory _name) public{
        Student memory new_std = Student({
            rn : _rn ,
            name :_name
 });
    s1=new_std;
    }
}