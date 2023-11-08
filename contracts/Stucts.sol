// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Structs {
    //structs can be used to create custom variables with different parameters and data types
    struct User {
        uint8 age;
        string name;
    }

    mapping(address => User) public users;

    //register -> anybody to register by providing their address and age
    function register(uint8 age, string memory name) external returns (bool) {
        users[msg.sender] = User(age, name);
        return true;
    }
}
