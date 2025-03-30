// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Fraud Detection for Land Registry
 * @dev Uses AI-based fraud detection for identifying suspicious transactions.
 */
contract FraudDetection {
    address public admin;
    mapping(bytes32 => bool) public flaggedTransactions;

    event TransactionFlagged(bytes32 indexed transactionHash, string reason);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not authorized");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function flagTransaction(bytes32 transactionHash, string memory reason) external onlyAdmin {
        flaggedTransactions[transactionHash] = true;
        emit TransactionFlagged(transactionHash, reason);
    }

    function isTransactionFlagged(bytes32 transactionHash) external view returns (bool) {
        return flaggedTransactions[transactionHash];
    }
}
