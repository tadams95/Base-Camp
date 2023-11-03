// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract BasicMath {
    function adder(
        uint _a,
        uint _b
    ) public pure returns (uint sum, bool error) {
        unchecked {
            if (_a + _b >= _a) {
                sum = _a + _b;
                error = false;
            } else {
                sum = 0;
                error = true;
            }
        }
    }

    function subtractor(
        uint _a,
        uint _b
    ) public pure returns (uint difference, bool error) {
        unchecked {
            if (_a >= _b) {
                difference = _a - _b;
                error = false;
            } else {
                difference = 0;
                error = true;
            }
        }
    }
}
