// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.8.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.0/contracts/utils/structs/EnumerableSet.sol";

library WeightedVotingLibrary {
    using EnumerableSet for EnumerableSet.AddressSet;

    // Struct to represent an issue
    struct Issue {
        EnumerableSet.AddressSet voters;
        string issueDesc;
        uint24 votesFor;
        uint24 votesAgainst;
        uint24 votesAbstain;
        uint24 totalVotes;
        uint24 quorum;
        bool passed;
        bool closed;
    }

    // Struct to view an issue
    struct IssueView {
        address[] voters;
        string issueDesc;
        uint24 votesFor;
        uint24 votesAgainst;
        uint24 votesAbstain;
        uint24 totalVotes;
        uint24 quorum;
        bool passed;
        bool closed;
    }

    // Enum for voting options
    enum Votes {
        AGAINST,
        FOR,
        ABSTAIN
    }
}

contract WeightedVoting is ERC20 {
    using EnumerableSet for EnumerableSet.AddressSet;
    using WeightedVotingLibrary for WeightedVotingLibrary.Issue;
    using WeightedVotingLibrary for WeightedVotingLibrary.IssueView;
    using WeightedVotingLibrary for WeightedVotingLibrary.Votes;

    //error functions
    error TokensClaimed();
    error AllTokensClaimed();
    error NoTokensHeld();
    error QuorumTooHigh(uint24 quorum);
    error AlreadyVoted();
    error VotingClosed();

    // Storage variables
    uint24 public maxSupply;
    uint24 public claimAmount;
    uint24 public claimedAmount;

    // Store address of token holder and balance
    mapping(address => uint24) public balances;

    // Keep track of whether a wallet has claimed tokens.
    mapping(address => bool) public hasClaimed;

    // Constructor to initialize ERC-20 token
    constructor(string memory _name, string memory _symbol)
        ERC20(_name, _symbol)
    {
        maxSupply = 1_000_000;
        claimAmount = 100;
        issues.push();
    }

    // Array of Issues
    WeightedVotingLibrary.Issue[] issues;

    // Public claim function
    function claim() public {
        if (claimedAmount > maxSupply) revert AllTokensClaimed();
        if (hasClaimed[msg.sender]) revert TokensClaimed();

        balances[msg.sender] += claimAmount;
        claimedAmount += claimAmount;
        hasClaimed[msg.sender] = true;
    }

    // Function to create an issue
    function createIssue(string memory _issueDesc, uint24 _quorum)
        external
        returns (uint256 idx)
    {
        require(
            balances[msg.sender] > 0,
            "Only token holders can create issues"
        );
        require(
            _quorum <= totalSupply(),
            "Quorum cannot be greater than the total number of tokens"
        );

        idx = issues.length;
        issues.push();
        WeightedVotingLibrary.Issue storage iss = issues[idx];
        iss.issueDesc = _issueDesc;
        iss.quorum = _quorum;
        return idx;
    }

    // Function to get an issue
    function getIssue(uint24 _id)
        external
        view
        returns (WeightedVotingLibrary.IssueView memory)
    {
        WeightedVotingLibrary.Issue storage issue = issues[_id];

        address[] memory voters = new address[](issue.voters.length());
        for (uint256 i = 0; i < issue.voters.length(); i++) {
            voters[i] = issue.voters.at(i);
        }

        return
            WeightedVotingLibrary.IssueView(
                voters,
                issue.issueDesc,
                issue.votesFor,
                issue.votesAgainst,
                issue.votesAbstain,
                issue.totalVotes,
                issue.quorum,
                issue.passed,
                issue.closed
            );
    }

    // Function to vote
    function vote(uint24 _issueId, WeightedVotingLibrary.Votes _vote) public {
        // Ensure that the issue is not closed
        require(!issues[_issueId].closed, "Voting is closed for this issue");

        // Ensure the wallet has not already voted on this issue
        require(
            !issues[_issueId].voters.contains(msg.sender),
            "Already voted on this issue"
        );

        // Record the voter's choice
        WeightedVotingLibrary.Issue storage issue = issues[_issueId];
        uint24 voterBalance = balances[msg.sender];

        if (_vote == WeightedVotingLibrary.Votes.FOR) {
            issue.votesFor += voterBalance;
        } else if (_vote == WeightedVotingLibrary.Votes.AGAINST) {
            issue.votesAgainst += voterBalance;
        } else if (_vote == WeightedVotingLibrary.Votes.ABSTAIN) {
            issue.votesAbstain += voterBalance;
        } else {
            revert("Invalid vote option");
        }

        // Update total votes and record the voter
        issue.totalVotes += voterBalance;
        issue.voters.add(msg.sender);

        // Check if the quorum is reached
        if (issue.totalVotes >= issue.quorum) {
            issue.closed = true;

            // Check if there are more votes for than against
            if (issue.votesFor > issue.votesAgainst) {
                issue.passed = true;
            }
        }
    }
}
