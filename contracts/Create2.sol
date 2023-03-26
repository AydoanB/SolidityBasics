//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TestContract {
    
    constructor(address owner) payable{

    }
}

contract Create2 {
    event Deploy(address addr);

    function deploy(uint _salt) external payable {
        TestContract _contract = new TestContract{salt: bytes32(_salt)}(msg.sender);

        emit Deploy(address(_contract));
    }

    function getAddress(bytes memory bytecode, uint _salt) public view returns(address){
        bytes32 hash = keccak256(abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode)));

        return address(uint160(uint(hash)));
    }

    function getBytecode(address _owner) public pure returns(bytes memory) {
        bytes memory bytecode = type(TestContract).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_owner));
    }
}