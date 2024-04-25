// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.2 <0.9.0;

contract PiggyBank {
    struct Account {
        uint256 balance;
        bool exists;
    }

    address owner;
    mapping(address => Account) accounts;

    constructor() {
        owner = msg.sender;
    }

    function storeFunds() public payable {
        accounts[msg.sender].balance += msg.value;
        accounts[msg.sender].exists = true;
    }

    function retrieveAccountFunds() public {
        require(accounts[msg.sender].exists, "Account does not exist");
        payable(msg.sender).transfer(accounts[msg.sender].balance);
        accounts[msg.sender].balance = 0;
    }

    function transferAccountFunds(address recipient) public {
        require(accounts[msg.sender].exists, "Sender account does not exist");
        require(accounts[msg.sender].balance > 0, "Sender account has no balance");
        require(accounts[recipient].exists, "Recipient account does not exist");
        require(recipient != address(0), "Invalid recipient address");
        uint256 amount = accounts[msg.sender].balance;
        accounts[msg.sender].balance = 0;
        accounts[recipient].balance += amount;
    }
}