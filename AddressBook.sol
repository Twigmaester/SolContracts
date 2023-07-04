// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
// import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract AddressBook is Ownable {

    error ContactNotFound(uint id);

    struct Contact {
        uint id;
        string firsName;
        string lastName;
        uint[] phoneNumbers;

    }
    
    Contact[] contacts;

    function addContact(uint _id, string calldata _firstName, string calldata _lastName, uint[] calldata _phoneNumbers) public onlyOwner{
        Contact memory newContact = Contact(_id, _firstName, _lastName, _phoneNumbers);
        contacts.push(newContact);
    }

    function deleteContact(uint _id) public onlyOwner{
        bool found = false;
        for (uint i=0; i<contacts.length; i++){
            if (contacts[i].id == _id){
                delete contacts[i];
                found = true;
            }
        }
        if (!found){
            revert ContactNotFound(_id);
        }

    }

    function getAllContacts() public view returns (Contact[] memory){
        return contacts;
    }
}


contract AddressBookFactory {
    function deploy() public returns (address) {
        AddressBook newAddressBook = new AddressBook();
        newAddressBook.transferOwnership(msg.sender);
        return address(newAddressBook);
    }
}