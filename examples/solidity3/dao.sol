/*
DAOs (Decentralized Governance)

Use case: Allow token holders to vote on proposals and manage a treasury.
Blockchain advantage: Transparent, tamper-proof governance, no central authority.
Example: DAO smart contract where anyone can propose actions, and token-weighted voting decides execution.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDAO {
    struct Proposal {
        string description;
        uint256 voteCount;
    }

    mapping(address => uint256) public votingPower;
    Proposal[] public proposals;

    constructor(address[] memory voters, uint256[] memory weights) {
        for (uint i = 0; i < voters.length; i++) {
            votingPower[voters[i]] = weights[i];
        }
    }

    function createProposal(string memory _desc) public {
        proposals.push(Proposal(_desc, 0));
    }

    function vote(uint proposalId) public {
        require(votingPower[msg.sender] > 0, "No voting power");
        proposals[proposalId].voteCount += votingPower[msg.sender];
        votingPower[msg.sender] = 0; // one-time vote
    }
}