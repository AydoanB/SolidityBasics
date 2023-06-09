//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Abi{
    struct  MyStruct {
        string name;
        uint[2] nums;
    }

    function encode(uint x, address addr, uint[] calldata arr, MyStruct calldata myStruct) external pure returns(bytes memory){
        return abi.encode(x, addr, arr, myStruct);
    }

    function decode(bytes calldata data) external pure returns(uint x, address addr, uint[] memory arr, MyStruct memory str){
        (x, addr, arr, str) = abi.decode(data,(uint, address, uint[], MyStruct));
    }
}