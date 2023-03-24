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

contract Helper{

    function getBal() external view returns(uint){
        return address(this).balance;
    }
    
    function destroyContract(Kill kill) external{
        kill.kill();
    }

    fallback() external payable{}
}