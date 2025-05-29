/*
Crowdfunding / ICO / Token Sales

Use case: Raise funds for a project.
Blockchain advantage: Public, auditable funding process; automatic refund if goal not met (like Kickstarter with code).
Example: Contributors get tokens in return for ETH, with soft/hard caps enforced in code.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfund {
    address public owner;
    uint public deadline;
    uint public goal;
    uint public raised;

    mapping(address => uint) public balances;
    bool public funded;

    constructor(uint _duration, uint _goal) {
        owner = msg.sender;
        deadline = block.timestamp + _duration;
        goal = _goal;
    }

    function contribute() public payable {
        require(block.timestamp < deadline, "Deadline passed");
        balances[msg.sender] += msg.value;
        raised += msg.value;
    }

    function withdraw() public {
        require(msg.sender == owner, "Not owner");
        require(raised >= goal, "Goal not met");
        funded = true;
        payable(owner).transfer(address(this).balance);
    }

    function refund() public {
        require(block.timestamp > deadline, "Too early");
        require(raised < goal, "Goal was met");
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}