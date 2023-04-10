// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "hardhat/console.sol";

/**
 * @title Store
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Hucha {

    address private owner;

    // event for EVM logging
    event OwnerSet(address indexed oldOwner, address indexed newOwner);

    // modifier to check if caller is owner
    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    constructor() {
        console.log("Owner contract deployed by:", msg.sender);
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        emit OwnerSet(address(0), owner);
    }

    function changeOwner(address newOwner) public isOwner {
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }

    function getOwner() external view returns (address) {
        return owner;
    }

    /* Hucha */

    mapping(address=>uint256) public cuentas;

    function store() payable public {
        cuentas[msg.sender] += msg.value;
    }

    function total() public view returns (uint256) {
        return address(this).balance;
    }

    function cuenta(address a) public view returns (uint256) {
        return cuentas[a];
    }

    function transfer(address payable recipient, uint256 amount) public isOwner {
        require( cuentas[msg.sender] > amount );
        recipient.transfer(amount);
        cuentas[msg.sender] -= amount;
    }
}