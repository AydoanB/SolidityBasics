//SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract LocalVariables{
    uint public globalUint;
    bool public x;
    address public myAddress;

    function foo() external {
        uint localUint = 123;
        bool f = false;

         localUint = localUint + 546;
         f = true;

         globalUint = 123;
         x = true;
         myAddress = address(1);
    }

    function globalVars() external view returns (address, uint, uint) {
        address sender = msg.sender;
        uint timeStamp = block.timestamp;
        uint blockNum = block.number;

        return (sender, timeStamp, blockNum);
    }
}