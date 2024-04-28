// SPDX-License-Identifier: GPL-3.0

// Open in Remix IDE online with: https://remix.ethereum.org/vicenteherrera/starter-blockchain/blob/main/examples/solidity/pay_example.sol

pragma solidity >=0.8.2 <0.9.0;

import "hardhat/console.sol";

/**
 * @title PayExample
 * @dev Store & retrieve Ether in a contract
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract payExample {

    function store() payable public {
        console.log("Received ", msg.value, " from ", msg.sender);
    }

    function getTotal() public view returns (uint256) {
        return address(this).balance;
    }

    function transfer(address payable recipient, uint256 amount) public {
        require( address(this).balance >= amount );
        recipient.transfer(amount);
    }
}
