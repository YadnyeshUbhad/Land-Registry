// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title DAO for Land Governance
 * @dev Decentralized voting system for resolving land disputes.
 */
contract DAO {
    struct Proposal {
        uint id;
        string description;
        uint voteCount;
        bool executed;
        mapping(address => bool) voted;
    }

    mapping(uint => Proposal) public proposals;
    mapping(address => bool) public members;
    uint public proposalCount;

    event ProposalCreated(uint id, string description);
    event VoteCasted(uint id, uint votes);
    event ProposalExecuted(uint id);

    modifier onlyMember() {
        require(members[msg.sender], "Not a DAO member");
        _;
    }

    constructor() {
        members[msg.sender] = true;
    }

    function addMember(address _member) external onlyMember {
        members[_member] = true;
    }

    function createProposal(string memory _description) external onlyMember {
        proposalCount++;
        Proposal storage newProposal = proposals[proposalCount];
        newProposal.id = proposalCount;
        newProposal.description = _description;
        newProposal.voteCount = 0;
        newProposal.executed = false;
        emit ProposalCreated(proposalCount, _description);
    }

    function vote(uint _proposalId) external onlyMember {
        Proposal storage proposal = proposals[_proposalId];
        require(!proposal.executed, "Proposal already executed");
        require(!proposal.voted[msg.sender], "Already voted");
        
        proposal.voteCount++;
        proposal.voted[msg.sender] = true;
        emit VoteCasted(_proposalId, proposal.voteCount);
    }

    function executeProposal(uint _proposalId) external onlyMember {
        Proposal storage proposal = proposals[_proposalId];
        require(proposal.voteCount > 2, "Not enough votes");
        require(!proposal.executed, "Already executed");
        
        proposal.executed = true;
        emit ProposalExecuted(_proposalId);
    }
}
