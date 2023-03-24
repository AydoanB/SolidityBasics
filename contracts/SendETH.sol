//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract ETHSender {
    constructor() payable {}
    
    function sendTransfer(address payable _to) external payable{
        _to.transfer(123);
    }

    function sendSend(address payable _to) external payable{
       bool success = _to.send(123);
       require(success, "Fail");
    }

    function sendCall(address payable _to) external payable{
       (bool success, bytes memory data) = _to.call{value: 123}("asdas");
       require(success, "Fail");
    }
}

contract ETHReceiver{
    event Rec(uint amount, uint gas);
    event RecCall(uint amount, uint gas, bytes  data);

    fallback() external payable{
        //emit Rec(msg.value, gasleft());
        emit RecCall(msg.value, gasleft(),msg.data);

    }
}