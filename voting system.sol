// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    struct Proposal {
        string description;
        uint voteCount;
    }

    address public chairperson;
    mapping(address => bool) public voters;
    Proposal[] public proposals;

    constructor() {
        chairperson = msg.sender;
    }

    function addProposal(string memory description) public {
        require(msg.sender == chairperson, "Only chairperson can add proposals");
        proposals.push(Proposal({
            description: description,
            voteCount: 0
        }));
    }

    function giveRightToVote(address voter) public {
        require(msg.sender == chairperson, "Only chairperson can give right to vote");
        require(!voters[voter], "The voter already has the right to vote");
        voters[voter] = true;
    }

    function vote(uint proposalIndex) public {
        require(voters[msg.sender], "Has no right to vote");
        require(proposalIndex < proposals.length, "Invalid proposal index");

        proposals[proposalIndex].voteCount += 1;
    }

    function winningProposal() public view returns (uint winningProposalIndex) {
        uint winningVoteCount = 0;
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningProposalIndex = i;
            }
        }
        return winningProposalIndex; // Return statement added
    }

    function winnerDescription() public view returns (string memory) {
        return proposals[winningProposal()].description;
    }
}
