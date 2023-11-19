// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyERC721 is ERC721 {
    uint256 public counter;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
        counter = 1;
    }

    function redeemNFT() external  {
        _safeMint(msg.sender, counter);
        counter++;
    }
}

