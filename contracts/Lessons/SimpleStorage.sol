// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract SimpleStorage {
    uint8 public age;
    uint8 public cars;

    constructor(uint8 _age, uint8 _cars) {
        age = _age;
        cars = _cars;
    }

    function updateNumberOfCars(uint8 _numberOfCars) public {
        cars = _numberOfCars;
    }

    function increaseAge() public {
        age++;
    }

    function adminSetAge(uint8 _age) public {
        age = _age;
    }
}
