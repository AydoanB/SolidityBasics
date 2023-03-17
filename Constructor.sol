//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract CtorDemo {
    address public owner;
    uint public x;

    constructor(uint _x){
        owner = msg.sender;
        x = _x;
    }

    function changeX(uint _newX) external doNotChangeOwner {
        x = _newX;
    }

    function changeOwner() external {
        owner =  0xE0f5206BBD039e7b0592d8918820024e2a7437b9;
    }

    modifier doNotChangeOwner() {
        assert(owner == msg.sender);
        _;
    }
}