//SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Counter {
    uint public count;

    function increment() external {
        count = count + 1;
    }

    function decrement() external {
        count = count - 1;
    }
}