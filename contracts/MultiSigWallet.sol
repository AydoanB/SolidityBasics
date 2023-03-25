//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiSigWallet {

    constructor(address[] memory _owners, uint _requiredConfirmations){
            require(_owners.length > 0, "min 1 owner");
            require(_requiredConfirmations > 0 && _requiredConfirmations <= _owners.length, "confirmations must be at least 1 or at most all owners for contract");

            for(uint i; i < _owners.length; i++){
                address owner = _owners[i];

                require(owner != address(0), "zero address");
                require(!isOwner[owner], "already owner");

                isOwner[owner] = true;
                owners.push(owner);
            }
            confirmationsRequired = _requiredConfirmations;
    }

    event Deposit(address indexed sender, uint amount, uint balance);
    event SubmitTransaction(address indexed owner, uint indexed txIndex, address indexed to, uint value, bytes data);
    event ConfirmTransaction(address indexed owner, uint txIndex);
    event RevokeConfirmation(address indexed owner, uint txIndex);
    event ExecuteTransaction(address indexed owner, uint txIndex);

    address[] public owners;
    Transaction[] public transactions;

    mapping(address => bool) public isOwner;
    mapping(uint => mapping(address => bool)) public isTxConfirmedForUser;

    uint public confirmationsRequired;

    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool isExecuted;
        uint numOfConfirmations;
    }

    modifier onlyOwner(){
        require(isOwner[msg.sender], "owner is not in the list");
        _;
    }

    modifier txExists(uint _txIndex){
        require(_txIndex < transactions.length, "unexisting txIndex");
        _;
    }

    modifier notConfirmed(uint _txIndex){
        require(!isTxConfirmedForUser[_txIndex][msg.sender], "tx is already confirmed");
        _;
    }

    modifier notExecuted(uint _txIndex){
        require(!transactions[_txIndex].isExecuted, "tx is already executed");
        _;
    }

    fallback() external payable{
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }

    function submitTransaction(address _to, uint _value, bytes memory _data) public onlyOwner {
        uint txIndex = transactions.length;

        transactions.push(
            Transaction({
            to: _to,
            value: _value,
            data: _data,
            isExecuted: false,
            numOfConfirmations: 0
        }));

        emit SubmitTransaction(msg.sender, txIndex, _to, _value, _data); 
    }

    function confirmTransaction(uint _txIndex) public onlyOwner txExists(_txIndex) notExecuted(_txIndex) notConfirmed(_txIndex){
        Transaction storage transaction = transactions[_txIndex];

        transaction.numOfConfirmations += 1;
        isTxConfirmedForUser[_txIndex][msg.sender] = true;

        emit ConfirmTransaction(msg.sender, _txIndex);
    }

    function executeTransaction(uint _txIndex) public onlyOwner txExists(_txIndex) notExecuted(_txIndex){
        Transaction storage transaction = transactions[_txIndex];

        require(transaction.numOfConfirmations >= confirmationsRequired, "not enough confirmations");
        transaction.isExecuted = true;

        (bool success, ) = transaction.to.call{value: transaction.value}(transaction.data);
        require(success,"invalid tx");

        emit ExecuteTransaction(msg.sender, _txIndex);
    }

    function revokeConfirmation(uint _txIndex) public onlyOwner txExists(_txIndex) notExecuted(_txIndex){
        Transaction storage transaction = transactions[_txIndex];

        require(isTxConfirmedForUser[_txIndex][msg.sender], "tx is not confirmed for user");

        transaction.numOfConfirmations -= 1;
        isTxConfirmedForUser[_txIndex][msg.sender] = false;

        emit RevokeConfirmation(msg.sender, _txIndex);
    }
}