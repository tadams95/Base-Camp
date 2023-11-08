// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FavoriteRecords {
    //public mapping, returns true if an album name has been added.
    //returns false if it has not
    mapping(string => bool) public approvedRecords;

    //indexes user addresses to a mapping of string record names
    //returns true or false depending if the user has marked album as their favorite
    mapping(address => mapping(string => bool)) public userFavorites;

    string[] public approvedRecordNames;

    //load approved records
    function loadApprovedRecords() external {
        approvedRecords["Thriller"] = true;
        approvedRecords["Back in Black"] = true;
        approvedRecords["The Bodyguard"] = true;
        approvedRecords["The Dark Side of the Moon"] = true;
        approvedRecords["Their Greatest Hits (1971-1975)"] = true;
        approvedRecords["Hotel California"] = true;
        approvedRecords["Come On Over"] = true;
        approvedRecords["Rumours"] = true;
        approvedRecords["Saturday Night Fever"] = true;
    }

    //function should return a list of all the names currently indexed in approvedRecords
    function getApprovedRecords() public pure returns (string[] memory) {
        string[] memory albums = new string[](9);
        albums[0] = "Thriller";
        albums[1] = "Back in Black";
        albums[2] = "The Bodyguard";
        albums[3] = "The Dark Side of the Moon";
        albums[4] = "Their Greatest Hits (1971-1975)";
        albums[5] = "Hotel California";
        albums[6] = "Come On Over";
        albums[7] = "Rumours";
        albums[8] = "Saturday Night Fever";
        return albums;
    }

    //function that accepts an album name as a parameter
    //IF the album is on the approved list, add it to list of msg.sender
    //ELSE, reject it with a custom error of `NotApproved` with the submitted name as an argument
    function addRecord(string memory albumName) external {
    require(approvedRecords[albumName], string(abi.encodePacked("NotApproved: ", albumName)));

    userFavorites[msg.sender][albumName] = true;
}


    //retrieves the list of favorites for any address
    function getUserFavorites(
        address user
    ) external view returns (string[] memory) {
        string[] memory albums = getApprovedRecords();
        string[] memory favorites;
        uint count;

        for (uint i = 0; i < albums.length; i++) {
            if (userFavorites[user][albums[i]]) {
                count++;
            }
        }

        favorites = new string[](count);
        count = 0;

        for (uint i = 0; i < albums.length; i++) {
            if (userFavorites[user][albums[i]]) {
                favorites[count] = albums[i];
                count++;
            }
        }
        return favorites;
    }

    //resets userFavorites for the sender
    function resetUserFavorites() external {
        address sender = msg.sender;
        for (uint i = 0; i < 9; i++) {
            delete userFavorites[sender][getApprovedRecords()[i]];
        }
    }
}
