//SPDX-License-Identification: MIT
pragma solidity ^0.8.0;

contract VerifySig{
    function verify(address _signer, string memory _message, bytes memory _sig) external pure returns(bool){
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getETHSignedMessageHash(messageHash);

        return recover(ethSignedMessageHash);
    }

    function getMessageHash(string memory _message) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_message));
    }

    function getETHSignedMessageHash(bytes32 _messageHash) public pure returns(bytes32){
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash));
    }

    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig) public pure returns(address){
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        ecrecover(_ethSignedMessageHash, v, r, s);
    }
}