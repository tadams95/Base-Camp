// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/utils/structs/EnumerableSet.sol";

contract Imports {
    using EnumerableSet for EnumerableSet.AddressSet;

    EnumerableSet.AddressSet private visitors;

    function registerVisitor() external {
        visitors.add(msg.sender);
    }
    
    function numberOfVisitors() external  view returns(uint) {
        return visitors.length();
    }
}

    