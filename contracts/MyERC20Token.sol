// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract KardashevNetwork is ERC20, ERC20Permit, Ownable {
    constructor(address initialOwner)
        ERC20("KardashevNetwork", "KW")
        ERC20Permit("KardashevNetwork")
        Ownable(initialOwner)
    {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}