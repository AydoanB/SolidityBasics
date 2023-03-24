//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherWallet {
    event Received(address from, uint amount);
    address public owner;

    constructor()  {
        owner = (msg.sender);
    }

    fallback() external payable{
        emit Received(msg.sender, msg.value);
    }

    function withdraw(uint amount) external {
        require(msg.sender == owner, "Only owner");
    //REMEMBER: state variables use more gas
        (bool success,) = payable(msg.sender).call{value: amount}("");

        require(success, "Send failed");
    }

    function getBalance() external view returns (uint){
        return address(this).balance;
    }
}