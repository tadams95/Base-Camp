// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "https://github.com/tadams95/Base-Camp/blob/master/contracts/SillyStringsUtils.sol";

contract ImportsExercise {
    using SillyStringUtils for string;
    SillyStringUtils.Haiku public Haiku;

    function saveHaiku(
        string memory _line1,
        string memory _line2,
        string memory _line3
    ) public {
        Haiku = SillyStringUtils.Haiku({
            line1: _line1,
            line2: _line2,
            line3: _line3
        });
    }

    function getHaiku() public view returns (SillyStringUtils.Haiku memory) {
        return Haiku;
    }

     function shruggieHaiku() public view returns (SillyStringUtils.Haiku memory) {
        SillyStringUtils.Haiku memory shruggieHaikuCopy = Haiku; // Create a copy to avoid modifying the original

        // Use the shruggie function to add 🤷 to the end of line3
        shruggieHaikuCopy.line3 = shruggieHaikuCopy.line3.shruggie();

        return shruggieHaikuCopy;
    }
}
