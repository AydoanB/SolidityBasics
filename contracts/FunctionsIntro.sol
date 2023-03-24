//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Error {
    // function testRequire(uint _i) public pure {
    //     require(_i <= 10, "i > 10");
    //     //code
    // }

    // function testRevert(uint _i) public pure {
    //     if(_i > 10){
    //         //code
    //         if(_i < 25){
    //         revert("i > 10");
    //         }
    //     }
    // }

    // uint public num = 123;

    // function testAssert() public view {
    //     assert(num == 123);
    // }

    // function assertBreaker() public {
    //     num += 1;
    // }

    error MyError(address callerAddress, uint i);

    uint public balance = msg.sender.balance;

    function customError(uint _i) public view {
        if(_i > 10){
            revert MyError(msg.sender, _i);    
        }
    }
}