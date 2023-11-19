// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BalanceReader {
    function getERC20BalanceOf(address _account, address _tokenAddress)
        external
        view
        returns (uint256)
    {
        // we create an instance only using the interface and the address
        return IERC20(_tokenAddress).balanceOf(_account);
    }
}