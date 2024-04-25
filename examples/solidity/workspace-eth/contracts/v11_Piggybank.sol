// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.2 <0.9.0;

contract PiggyBank {
    address owner;
    uint256 balance;

    constructor() {
        owner = msg.sender;
    }

    function storeFunds() public payable {
        balance += msg.value;
    }

    function retrieveFunds() public {
        require(msg.sender == owner, "Only owner can retrieve funds");
        payable(owner).transfer(balance);
        balance = 0;
    }

    // Improvement

    function transferFunds(address recipient) public {
        require(msg.sender == owner, "Only owner can transfer funds");
        require(recipient != address(0), "Invalid recipient address");
        payable(recipient).transfer(balance);
        balance = 0;
    }
}