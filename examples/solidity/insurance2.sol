// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "hardhat/console.sol"; // <- do not forget

contract Insurance {

    //--- COPY from 2_Owner.sol  ---------------------------

    address private owner;

    // event for EVM logging
    event OwnerSet(address indexed oldOwner, address indexed newOwner);

    // modifier to check if caller is owner
    modifier isOwner() {
        // If the first argument of 'require' evaluates to 'false', execution terminates and all
        // changes to the state and to Ether balances are reverted.
        // This used to consume all gas in old EVM versions, but not anymore.
        // It is often a good idea to use 'require' to check if functions are called correctly.
        // As a second argument, you can also provide an explanation about what went wrong.
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    /**
     * @dev Set contract deployer as owner
     */
    constructor() {
        console.log("Owner contract deployed by:", msg.sender);
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        emit OwnerSet(address(0), owner);
    }

    /**
     * @dev Change owner
     * @param newOwner address of new owner
     */
    function changeOwner(address newOwner) public isOwner {
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }

    /**
     * @dev Return owner address 
     * @return address of owner
     */
    function getOwner() external view returns (address) {
        return owner;
    }

    // -- From slide ----------------------------------

    uint256 public payoutAmount;
    uint256 public premiumAmount;
    bool public isClaimed;

    function claimInsurance() public {
        require(!isClaimed);
        isClaimed = true;
        payable(msg.sender).transfer(payoutAmount);
    }

    //-- Created new code here -----------------------------

    function setPayAmount(uint256 newAmount) public payable isOwner {
        // Stored money plus sent here has to be equal or more than newAmount
        require( address(this).balance >= newAmount );
        payoutAmount = newAmount;
    }

    function setPremiumAmount(uint256 newPremiumAmount) public payable isOwner {
        // Stored money plus sent here has to be equal or more than newAmount
        require( address(this).balance >= newPremiumAmount );
        premiumAmount = newPremiumAmount;
    }

    // 1º) setPayAmount(10) + 10 Eth
    // 2º) setPremiumAmount(12) + 2 Eth

}