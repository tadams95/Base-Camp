// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ArrayDemo {
    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    function getEvenNumbers() external view returns (uint[] memory) {
        uint resultsLength = _countEvenNumbers();
        uint[] memory results = new uint[](resultsLength);
        uint cursor = 0;

        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                results[cursor] = numbers[i];
                cursor++;
            }
        }

        return results;
    }

    function _countEvenNumbers() internal view returns (uint) {
        uint result = 0;

        for (uint i = 0; i < numbers.length; i++) {
            if (i % 2 == 0) {
                result++;
            }
        }
        return result;
    }

    function debugLoadArray(uint _number) external {
        for (uint i = 0; i < _number; i++) {
            numbers.push(i);
        }
    }
}
