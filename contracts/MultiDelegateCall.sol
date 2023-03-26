//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiDelegateCall{
    error DelegatecallFailed();

    function multiDelegateCall(bytes[] memory data) external payable returns(bytes[] memory results) {
        results = new bytes[](data.length);

        for(uint i; i < data.length;){
            (bool ok, bytes memory res) = address(this).delegatecall(data[i]);
            if(!ok) 
                revert DelegatecallFailed();
            
            results[i] = res;

            unchecked{ ++i; }
        }
    }
}

contract TestDelegateCall is MultiDelegateCall{
    event Log(address caller, string func, uint i);

    function func1(uint x, uint y) external{
        emit Log(msg.sender, "func1", x+y);
    }

    function func2() external returns(uint){
        emit Log(msg.sender, "func2", 2);
        return 111;
    }
}

contract Helper{
    function getByteFunc1(uint x, uint y) external pure returns(bytes memory){
        return abi.encodeWithSelector(TestDelegateCall.func1.selector, x, y);
    }

    function getByteFunc2() external pure returns(bytes memory){
        return abi.encodeWithSelector(TestDelegateCall.func2.selector);
    }
}