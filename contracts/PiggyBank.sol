//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PiggyBank{
    event Withdraw(address indexed _to, uint value);
    event Receive(address indexed sender, uint value);

    address public owner = msg.sender;

    receive() external payable {
        emit Receive(msg.sender, msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "only owner");
        emit Withdraw(msg.sender, getBalance());
        selfdestruct(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}