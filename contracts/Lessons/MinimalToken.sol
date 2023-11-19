// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MinimalToken {
    //store address of token holder and balance
    mapping(address => uint256) public balances;

    uint256 public totalSupply;

    constructor() {
        totalSupply = 3000;

        //the address which deploys the contract is assigned the total supply
        balances[msg.sender] = totalSupply / 3;

        balances[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2] = totalSupply / 3;

        balances[0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db] = totalSupply / 3;
    }

    function transfer(address _to, uint256 _amount) external {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_to] = balances[_to] + _amount;
    }
}
