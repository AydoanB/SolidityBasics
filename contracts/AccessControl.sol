//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

contract AccessControl{
    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokeRole(bytes32 indexed role, address indexed account);
    mapping(bytes32 => mapping(address => bool)) public roles;

    bytes32 public constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    bytes32 public constant USER = keccak256(abi.encodePacked("USER"));

    modifier onlyAdmin(bytes32 _role){
        require(roles[_role][msg.sender], "only admin");
        _;
    }

    constructor(){
        _grantRole(ADMIN, msg.sender);
    }

    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    function grantRole(bytes32 _role, address _account) external onlyAdmin(ADMIN) {
        _grantRole(_role, _account);
    }

    function revokeRole(bytes32 _role, address _account) external onlyAdmin(ADMIN){
        roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    }

}