//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC20.sol";

contract CSAMM {
    IERC20 public immutable token0;
    IERC20 public immutable token1;

    uint public reserve0;
    uint public reserve1;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    constructor(address _token0, address _token1){
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
    }

    function _update(uint res0, uint res1) private {
        reserve0 = res0;
        reserve1 = res1;
    }

    function _mint(address _to, uint _amount) private {
        balanceOf[_to] += _amount;
        totalSupply += _amount;
    }

    function _burn(address _from, uint _amount) private {
        balanceOf[_from] -= _amount;
        totalSupply -= _amount;
    }

    function swap(address _tokenIn, uint _amountIn) external returns(uint amountOut) {
        require(_tokenIn == address(token0) || _tokenIn == address(token1), "invalid");

        bool isToken0 = _tokenIn == address(token0);

        (IERC20 tokenIn, IERC20 tokenOut, uint resIn, uint resOut) = isToken0 ? 
        (token0, token1, reserve0, reserve1) : (token1, token0, reserve1, reserve0);

        tokenIn.transferFrom(msg.sender,address(this), _amountIn);
        uint amountIn = tokenIn.balanceOf(address(this)) - resIn;

        //Calculate fee (currently it is 0%)
        amountOut = amountIn;
        //If fee 0.3%
        //amountOut = (amountIn * 997) /1000;

        if(isToken0)
            _update(resIn + _amountIn, resOut - amountOut); 
        else 
            _update(resIn - amountOut, resOut + _amountIn);   

        tokenOut.transfer(msg.sender, amountOut);
    }
    function addLiquidity(uint _amount0, uint _amount1) external returns(uint shares) {
        token0.transferFrom(msg.sender, address(this), _amount0);
        token1.transferFrom(msg.sender, address(this), _amount1);

        uint bal0 = (token0.balanceOf(address(this)));
        uint bal1 = (token1.balanceOf(address(this)));

        uint diff0 = bal0 - reserve0;
        uint diff1 = bal1 - reserve1;

        if(totalSupply == 0){
            shares = diff0 + diff1;
        } else {
            shares = ((diff0 + diff1) * totalSupply) / (reserve0 + reserve1);
        }

        require(shares > 0, "min 1 share");
        _update(bal0, bal1);
    }

    function removeLiquidity(uint _shares) external returns (uint d0, uint d1) {
        d0 = (reserve0 * _shares) / totalSupply;
        d1 = (reserve1 * _shares) / totalSupply;

        _burn(msg.sender, _shares);
        _update(reserve0 - d0, reserve1 - d1);

        if(d0 > 0){
            token0.transfer(msg.sender, d0);
        }
        if(d1 > 0){
            token1.transfer(msg.sender, d1);
        }
    }

}