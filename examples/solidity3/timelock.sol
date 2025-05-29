/*
Time-locked Vaults or Wills

Use case: Lock assets until a future date or condition (e.g., death).
Blockchain advantage: Automatic execution, no need for lawyer/custodian.
Example: Contract that only releases funds after a given block timestamp.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TimeLock {
    address public owner;
    uint256 public unlockTime;

    constructor(uint256 _unlockTime) payable {
        require(_unlockTime > block.timestamp, "Unlock time in the past");
        owner = msg.sender;
        unlockTime = _unlockTime;
    }

    function withdraw() public {
        require(msg.sender == owner, "Not owner");
        require(block.timestamp >= unlockTime, "Too early");
        payable(owner).transfer(address(this).balance);
    }
}