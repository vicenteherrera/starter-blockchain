/*
Escrow Contracts (Trustless Transactions)

Use case: Buying goods or services from unknown parties.
Blockchain advantage: Funds are held securely in the contract and only released when conditions are met (e.g., buyer confirms receipt).
Example: Buyer, seller, and optionally an arbitrator interact.
*/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Escrow {
    address public buyer;
    address payable public seller;
    address public arbiter;
    bool public isReleased;

    constructor(address _seller, address _arbiter) payable {
        buyer = msg.sender;
        seller = payable(_seller);
        arbiter = _arbiter;
        isReleased = false;
    }

    function releaseFunds() public {
        require(msg.sender == buyer || msg.sender == arbiter, "Not authorized");
        require(!isReleased, "Already released");
        isReleased = true;
        seller.transfer(address(this).balance);
    }

    function refundBuyer() public {
        require(msg.sender == arbiter, "Only arbiter can refund");
        require(!isReleased, "Already released");
        isReleased = true;
        payable(buyer).transfer(address(this).balance);
    }
}
