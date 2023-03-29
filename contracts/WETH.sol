//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@rari-capital/solmate/scr/tokens/ERC20.sol";

contract WETH is ERC20{
    event Deposit(address indexed account, uint amount);
    event Withdraw(address indexed account, uint amount);

    constructor() ERC20("Wrapped Ether", "WETH", 18){

    }

    function deposit() public payable{
        _mint(msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    function Withdraw(uint _amount) external {
        _burn(msg.sender, _amount);
        payable(msg.sender).transfer(_amount);
        emit Withdraw(msg.sender, _amount);
    }

    fallback() external payable{
        deposit();
    }
}