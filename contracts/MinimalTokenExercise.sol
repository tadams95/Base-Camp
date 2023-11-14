// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract UnburnableToken {
    // Store address of token holder and balance
    mapping(address => uint256) public balances;

    // Keep track of whether a wallet has claimed tokens.
    mapping(address => bool) public hasClaimed;

    uint256 public totalSupply;
    uint256 public totalClaimed;
    uint256 public claimAmount;

    constructor() {
        totalSupply = 100000000;
        claimAmount = 1000;
    }

    // Custom error for when a wallet tries to claim a second time
    error TokensClaimed();

    error UnsafeTransfer(address _to);

    // Checks if tokens can be claimed and increments balance, updates total claimed, sets hasClaimed to be true
    function claim() public {
        require(totalClaimed < totalSupply, "AllTokensClaimed");
        if (hasClaimed[msg.sender]) revert TokensClaimed();

        balances[msg.sender] += claimAmount;
        totalClaimed += claimAmount;
        hasClaimed[msg.sender] = true;
    }

    // Checks if the transfer is valid and performs the transfer
    function safeTransfer(address _to, uint _amount) public {
        if (_to == address(0)) {
            revert UnsafeTransfer(_to);
        }
        uint currentBalance = balances[msg.sender];
        if (currentBalance < _amount) {
            revert UnsafeTransfer(_to);
        }

        if (_to.balance == 0) {
            revert UnsafeTransfer(_to);
        }

        balances[msg.sender] = currentBalance - _amount;
        balances[_to] += _amount;
    }
}
