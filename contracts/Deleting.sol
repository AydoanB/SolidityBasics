//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Kill{

    constructor() payable{}

    function kill() external{
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns(uint){
        return 123;
    }
}