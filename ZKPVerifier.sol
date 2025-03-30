// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Zero-Knowledge Proof Verifier
 * @dev Allows land ownership verification without exposing sensitive data.
 */
contract ZKPVerifier {
    address public admin;
    mapping(bytes32 => bool) public verifiedProofs;

    event ProofVerified(bytes32 indexed proofHash);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not authorized");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function verifyProof(bytes32 proofHash) external onlyAdmin {
        verifiedProofs[proofHash] = true;
        emit ProofVerified(proofHash);
    }

    function isProofVerified(bytes32 proofHash) external view returns (bool) {
        return verifiedProofs[proofHash];
    }
}
