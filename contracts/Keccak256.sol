//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HashFunc{

    function hash(string memory text, uint num, address addr) external pure returns(bytes32){
        return keccak256(abi.encodePacked(text, num, addr));
    }

    function abiEncode(string memory text1, string memory text2) external pure returns (bytes memory res){
        res = abi.encode(text1, text2);
    }

     function abiEncodePacked(string memory text1, string memory text2) external pure returns (bytes memory res){
        res = abi.encodePacked(text1, text2);
    }

    //TO avoid hash collision 2 dynamic data types args don't have to be next to each other
     function collision(string memory text1, string memory text2) external pure returns (bytes32 res){
        res = keccak256(abi.encodePacked(text1, uint256(2) , text2));
    }
}