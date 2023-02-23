// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract Wallet {
    event Deposit(address indexed sender, uint amount);
    event Submit(uint indexed txIndex);
    event Approve(address indexed owner, uint indexed txId);
    event Revoke(address indexed owner, uint indexed txIndex);
    event Execute(uint indexed txIndex);

    struct Transaction{
        address to;
        uint value;
        bytes data;
        bool executed;
    }


   address[] public Owner;
    mapping(address => bool) public isOwner; 
    uint public required;
    
    Transaction [] public transactions;

    mapping(uint => mapping(address => bool)) public approved;

    modifier OnlyOwner (){
        require(isOwner[msg.sender],"Owner Required ");
        _;
    }

    modifier TransExist (uint _txid){
        require(_txid <transactions.length ,"Transaction does not Exist");
        _;
    }

    modifier NotApproved (uint _txid){
        require(!approved[_txid][msg.sender],"Already Approved ");
        _;
    }

    modifier NotExecuted (uint _txid){
        require(!transactions[_txid].executed,"Already Executed");
        _;
    }

    constructor(address [] memory _owner, uint _required) {
        require(_owner.length >  0, "Owner Required");
        require(_required > 0 && _required <= _owner.length, "Invalid Numbers" );

        for(uint i; i<_owner.length; i++){
            address owner = _owner[i];
            require(owner != address(0) , "Invalid Owner");
            require(!isOwner[owner], "Owner is not Unique" );
            isOwner[owner] = true;
            Owner.push(owner);
        }
        required = _required;
    }

    receive() external payable{
        emit Deposit(msg.sender,msg.value);
    }

    function SubmitTransaction(address _to , uint _value, bytes calldata _data) external OnlyOwner{
        transactions.push(Transaction({
            to:_to,
            value:_value,
            data:_data,
            executed : false
    }));
    emit Submit(transactions.length - 1);        
    }

    function AproveTransaction(uint _txid) external OnlyOwner()
    TransExist(_txid) NotApproved(_txid) NotExecuted(_txid){
        approved[_txid][msg.sender] = true;
        emit Approve(msg.sender , _txid);
    }

    function getapproved(uint _txid) private view returns(uint count){
        for(uint i ; i < Owner.length; i++){
            if(approved[_txid][Owner[i]]){
                count += 1;
            }
        }
    }
    function ExecuteTransaction(uint _txid) external TransExist(_txid) NotExecuted(_txid) {
        require(getapproved(_txid) >= required,"approval allow");
        Transaction storage transaction = transactions[_txid];
        transaction.executed=true; 
        (bool success,) = transaction.to.call{value:transaction.value}(
            transaction.data);
            require(success, "Transaction Failed");
                emit Execute(_txid);
    }

    function RevokeTransaction(uint _txid) external OnlyOwner TransExist(_txid) NotExecuted(_txid) {
        require(approved[_txid][msg.sender], "Approval Failed ");
        approved[_txid][msg.sender]= false;
        emit Revoke(msg.sender, _txid);
    }


}
   