// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

error NotOwner();
error InvalidOwner();
error OwnerNotUnique();
error OwnersRequired();
error OwnersLimit();

error InvalidConfirmationsNumber();

error TransactionNotExist();
error TransactionAlreadyConfirmed();
error TransactionAlreadyExecuted();

contract MultiSigWalletOptimized {
    address[3] public owners;
    uint256 public currentOwnersCount;
    uint256 public required;

    struct Transaction {
        address destination;
        uint256 value;
        uint32 executionTimestamp;
        uint8 confirmationCount;
        bool executed;
    }

    Transaction[] public transactions;

    mapping(uint256 => mapping(address => bool)) public confirmations;
    mapping(address => bool) public isOwnerMapping;

    event Submission(uint256 indexed transactionId);
    event Confirmation(address indexed owner, uint256 indexed transactionId);
    event Execution(uint256 indexed transactionId);
    event ExecutionFailure(uint256 indexed transactionId);

    modifier onlyOwner() {
        if (!isOwnerMapping[msg.sender]) {
            revert NotOwner();
        }
        _;
    }

    modifier transactionExists(uint256 transactionId) {
        if (transactionId >= transactions.length) {
            revert TransactionNotExist();
        }
        _;
    }

    modifier notConfirmed(uint256 transactionId) {
        if (confirmations[transactionId][msg.sender]) {
            revert TransactionAlreadyConfirmed();
        }
        _;
    }

    modifier notExecuted(uint256 transactionId) {
        if (transactions[transactionId].executed) {
            revert TransactionAlreadyExecuted();
        }
        _;
    }

    constructor(address[] memory _owners, uint256 _required) {
        uint256 ownersLen = _owners.length;

        if (ownersLen > 10) {
            revert OwnersLimit();
        }

        if (ownersLen <= 0) {
            revert OwnersRequired();
        }

        if (_required <= 0) {
            if (_required > ownersLen) {
                revert InvalidConfirmationsNumber();
            }
        }

        for (uint256 i; i < ownersLen; i++) {
            address owner = _owners[i];

            if (owner == address(0)) {
                revert InvalidOwner();
            }

            owners[currentOwnersCount++] = owner;

            if (isOwnerMapping[owner]) {
                revert OwnerNotUnique();
            }

            isOwnerMapping[owner] = true;
        }

        required = _required;
    }

    receive() external payable {}

    function submitTransaction(address destination, uint256 value) public onlyOwner {
        transactions.push(
            Transaction({
                destination: destination,
                value: value,
                executionTimestamp: 0,
                confirmationCount: 0,
                executed: false
            })
        );

        emit Submission(transactions.length);
    }

    function confirmTransaction(uint256 transactionId)
        public
        onlyOwner
        transactionExists(transactionId)
        notConfirmed(transactionId)
    {
        confirmations[transactionId][msg.sender] = true;
        transactions[transactionId].confirmationCount += 1;

        emit Confirmation(msg.sender, transactionId);

        if (transactions[transactionId].confirmationCount >= required) {
            executeTransaction(transactionId);
        }
    }

    function executeTransaction(uint256 transactionId)
        public
        onlyOwner
        transactionExists(transactionId)
        notExecuted(transactionId)
    {
        if (transactions[transactionId].confirmationCount >= required) {
            transactions[transactionId].executed = true;

            (bool success,) = transactions[transactionId].destination.call{value: transactions[transactionId].value}("");

            if (success) {
                emit Execution(transactionId);
            } else {
                transactions[transactionId].executed = false;
                emit ExecutionFailure(transactionId);
            }
        }
    }

    function getTransactionCount() external view returns (uint256) {
        return transactions.length;
    }

    function getConfirmations(uint256 transactionId) public view returns (address[] memory) {
        uint8 confirmationCount = transactions[transactionId].confirmationCount;
        address[] memory confirmationsTrimmed = new address[](confirmationCount);
        uint256 count = 0;

        for (uint256 i = 0; i < owners.length; i++) {
            if (confirmations[transactionId][owners[i]]) {
                confirmationsTrimmed[count] = owners[i];
                count++;

                if (count == confirmationCount) break;
            }
        }

        return confirmationsTrimmed;
    }

}

///////////////////

contract MultiSigWallet {
    address[] public owners;
    uint256 public required;

    struct Transaction {
        uint256 transactionID;
        address destination;
        uint256 value;
        uint256 confirmationCount;
        uint256 executionTimestamp;
        bool executed;
    }

    Transaction[] public transactions;
    mapping(uint256 => mapping(address => bool)) public confirmations;

    event Deposit(address indexed sender, uint256 value);
    event Submission(uint256 indexed transactionId);
    event Confirmation(address indexed owner, uint256 indexed transactionId);
    event Execution(uint256 indexed transactionId);
    event ExecutionFailure(uint256 indexed transactionId);

    modifier onlyOwner() {
        require(isOwner(msg.sender), "Not owner");
        _;
    }

    modifier transactionExists(uint256 transactionId) {
        require(transactionId < transactions.length, "Transaction does not exist");
        _;
    }

    modifier notConfirmed(uint256 transactionId) {
        require(!confirmations[transactionId][msg.sender], "Transaction already confirmed");
        _;
    }

    modifier notExecuted(uint256 transactionId) {
        require(!transactions[transactionId].executed, "Transaction already executed");
        _;
    }

    constructor(address[] memory _owners, uint256 _required) {
        require(_owners.length > 0, "Owners required");
        require(_required > 0 && _required <= _owners.length, "Invalid number of required confirmations");

        for (uint256 i = 0; i < _owners.length; i++) {
            require(_owners[i] != address(0), "Invalid owner");
            owners.push(_owners[i]);
        }

        required = _required;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function submitTransaction(address destination, uint256 value) public onlyOwner {
        transactions.push(
            Transaction({
                transactionID: transactions.length,
                destination: destination,
                value: value,
                confirmationCount: 0,
                executionTimestamp: 0,
                executed: false
            })
        );

        emit Submission(transactions.length);
    }

    function confirmTransaction(uint256 transactionId)
        public
        onlyOwner
        transactionExists(transactionId)
        notConfirmed(transactionId)
    {
        confirmations[transactionId][msg.sender] = true;
        transactions[transactionId].confirmationCount += 1;

        emit Confirmation(msg.sender, transactionId);

        if (transactions[transactionId].confirmationCount >= required) {
            executeTransaction(transactionId);
        }
    }

    function executeTransaction(uint256 transactionId)
        public
        onlyOwner
        transactionExists(transactionId)
        notExecuted(transactionId)
    {
        if (transactions[transactionId].confirmationCount >= required) {
            transactions[transactionId].executed = true;

            (bool success,) = transactions[transactionId].destination.call{value: transactions[transactionId].value}("");
            if (success) {
                emit Execution(transactionId);
            } else {
                transactions[transactionId].executed = false;
                emit ExecutionFailure(transactionId);
            }
        }
    }

    function isOwner(address account) public view returns (bool) {
        for (uint256 i = 0; i < owners.length; i++) {
            if (owners[i] == account) {
                return true;
            }
        }
        return false;
    }

    function getTransactionCount() public view returns (uint256) {
        return transactions.length;
    }

    function getConfirmations(uint256 transactionId) public view returns (address[] memory) {
        address[] memory _confirmations = new address[](owners.length);
        uint256 count = 0;

        for (uint256 i = 0; i < owners.length; i++) {
            if (confirmations[transactionId][owners[i]]) {
                _confirmations[count] = owners[i];
                count += 1;
            }
        }

        address[] memory confirmationsTrimmed = new address[](count);
        for (uint256 i = 0; i < count; i++) {
            confirmationsTrimmed[i] = _confirmations[i];
        }

        return confirmationsTrimmed;
    }
}
