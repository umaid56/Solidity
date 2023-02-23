// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract loop{
    uint [5] public  arr;
    uint public count;

    function Loop(uint _value) public{                                          // ForLOOP
    for(uint i= count ; i<arr.length; i++){
           arr[count] = count;
           count++;
       }


    }
    
    // function Loop() public{                                      //While Loop
    //     while (count<arr.length){
    //         arr[count] = count;
    //         count++;
    //     }
    // }
    
    // function Loop() public{                                        //Do-While Loop
    //   do{
    //       arr[count]=count;
    //       count++;
    //   }
    //   while(count<arr.length);
    // }   
}