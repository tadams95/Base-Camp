// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, 1000 ether);
    }
}

contract PoolCreator {
    IUniswapV3Factory public uniswapFactory;

    constructor(address _factoryAddress) {
        uniswapFactory = IUniswapV3Factory(_factoryAddress);
    }

    function createPool(
        address tokenA,
        address tokenB,
        uint24 fee
    ) external returns (address poolAddress) {
        //check if pool already exists
        poolAddress = uniswapFactory.getPool(tokenA, tokenB, fee);
        if (poolAddress == address(0)) {
            //if pool doesn't exist, create a new one
            poolAddress = uniswapFactory.createPool(tokenA, tokenB, fee);
        }
        return poolAddress;
    }
}
