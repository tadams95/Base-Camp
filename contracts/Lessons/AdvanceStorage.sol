// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract AdvanceStorage {
    mapping(address => uint8) public ages;

    //register -> anybody to register by providing their address and age
    function register(uint8 age) external returns (bool) {
        ages[msg.sender] = age;
        return true;
    }
}
