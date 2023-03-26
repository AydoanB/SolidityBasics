//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FuncsToCall {
    function func1() external view returns(uint, uint){
        return (1, block.timestamp);
    }

    function func2() external view returns(uint, uint){
        return (2, block.timestamp);
    }

    function getData1() external pure returns(bytes memory){
        return abi.encodeWithSelector(this.func1.selector);
    }

    function getData2() external pure returns(bytes memory){
        return abi.encodeWithSelector(this.func2.selector);
    }
}

contract FuncCaller {
    
    function multiCall(address[] calldata addresses, bytes[] calldata data) external view returns(bytes[] memory){
        require(addresses.length == data.length, "unequal");

        bytes[] memory results = new bytes[](data.length);

        for(uint i; i < addresses.length; ){
            (bool success, bytes memory result) = addresses[i].staticcall(data[i]);
            require(success, "failed");
            results[i] = result;

            unchecked {
                ++i;
            }
        }

        return results;
    }
}