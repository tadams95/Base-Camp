// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/09329f8a18f08df65863a5060f6e776bf7fccacf/contracts/access/Ownable.sol";

contract AddressBook is Ownable {
    //struct to represent a contact
    struct Contact {
        uint256 id;
        string firstName;
        string lastName;
        uint256[] phoneNumbers;
    }

    //mapping to store contacts
    mapping(uint256 => Contact) private contacts;

    //event to log contact addition
    event ContactAdded(uint256 indexed id, string firstName, string lastName);

    // Event to log contact deletion
    event ContactDeleted(uint256 indexed id, string firstName, string lastName);

    // Custom error for when a contact is not found
    error ContactNotFound(uint256 id);

    // Function to add a contact
    function addContact(
        uint256 _id,
        string memory _firstName,
        string memory _lastName,
        uint[] memory _phoneNumbers
    ) external onlyOwner {
        Contact storage newContact = contacts[_id];
        newContact.id = _id;
        newContact.firstName = _firstName;
        newContact.lastName = _lastName;
        newContact.phoneNumbers = _phoneNumbers;

        emit ContactAdded(_id, _firstName, _lastName);
    }

    // Function to delete a contact
    function deleteContact(uint256 _id) external onlyOwner {
        Contact storage contactToDelete = contacts[_id];
        require(contactToDelete.id == _id, "ContactNotFound");

        emit ContactDeleted(
            _id,
            contactToDelete.firstName,
            contactToDelete.lastName
        );

        delete contacts[_id];
    }

    // Function to get contact information
    function getContact(
        uint256 _id
    )
        external
        view
        returns (
            uint256 id,
            string memory firstName,
            string memory lastName,
            uint[] memory phoneNumbers
        )
    {
        Contact storage requestedContact = contacts[_id];
        if (requestedContact.id != _id) {
            revert ContactNotFound(_id);
        }

        return (
            requestedContact.id,
            requestedContact.firstName,
            requestedContact.lastName,
            requestedContact.phoneNumbers
        );
    }

    // Function to get all contacts
function getAllContacts() external view returns (Contact[] memory) {
    uint256 contactCount = 0;
    for (uint256 i = 1; i <= contacts.length; i++) {
        if (contacts[i].id == i) {
            contactCount++;
        }
    }

    Contact[] memory allContacts = new Contact[](contactCount);
    uint256 index = 0;
    for (uint256 i = 1; i <= contacts.length; i++) {
        if (contacts[i].id == i) {
            allContacts[index] = contacts[i];
            index++;
        }
    }

    return allContacts;
}

}

contract AddressBookFactory {
    function deply() external returns (AddressBook) {
        AddressBook ab = new AddressBook();
        ab.transferOwnership(msg.sender);
        return ab;
    }
}
