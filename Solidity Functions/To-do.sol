// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract To_Do{

    struct Todo{
        string text;
        bool completed;
    }

    Todo[] public data;

    function Create(string calldata _text) public{
        data.push(Todo({
            text : _text,
            completed : false
        }));
    }
    function Update(uint index, string calldata _text) public {
        data[index].text = _text;
    }
    function get( uint _index) external view returns(string memory , bool){
        Todo memory todo = data[_index];
        return (todo.text, todo.completed);
    }

    function ChangeStatus(uint _index) external{
        data[_index].completed =! data[_index].completed;
    }
}