//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC20.sol";

contract ERC20 is IERC20{
    event Approve(address indexed owner, address indexed spender, uint amount);
    
    string constant ERROR_MESSAGE = "not enough tokens";
    uint public totalSupply;

    mapping(address => uint) public balanceOf;
    mapping (address => mapping(address => uint)) public allowance;

    string public name = "Test";
    string public symbol = "TEST";
    uint8 public decimals = 18;

    function transfer(address recipient, uint amount) external returns(bool){
        require(recipient != address(0), "zero address");
        
        require(balanceOf[msg.sender] >= amount, ERROR_MESSAGE);

        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
        
        return true;
    }

    function approve(address spender, uint amount) external returns(bool){
        require(balanceOf[msg.sender] >= amount, ERROR_MESSAGE);
        allowance[msg.sender][spender] += amount;

        emit Approve(msg.sender, spender, amount);
        
        return true;
    }

    function transferFrom(address from, address to, uint amount) external returns(bool){
        require(balanceOf[from] >= amount, ERROR_MESSAGE);
        require(to != address(0), "zero address");

        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;

       return true;
    }

    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;

        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external{
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;

        emit Transfer(msg.sender, address(0), amount);
    }
}