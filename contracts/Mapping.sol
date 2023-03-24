//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// contract Mapping{
//     mapping(address => uint) public balances;
//     mapping(address => mapping(address => bool)) public areAddressesFriends;

//     address public test = address(this);
//     function examples() external{
//         balances[msg.sender] = 123;

//         uint bal = balances[msg.sender];
//         uint bal2 = balances[address(1)];

//         delete balances[msg.sender];

//         areAddressesFriends[msg.sender][address(this)] = true;
//     }
// }
contract ItterableMapping{
    mapping(address => uint) public balances;
    mapping(address => bool) public inserted;
    address[] public keys;
    address public zeroAddr = address(0);

    function insert(address _key, uint _value) external{
        balances[_key] = _value;

        if(!inserted[_key]){
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() external view returns(uint){
        return keys.length;
    }

    function get(uint _i) external view returns(uint){
        return balances[keys[_i]];
    }
    
}