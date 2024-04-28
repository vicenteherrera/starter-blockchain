// SPDX-License-Identifier: MIT

// Open in Remix IDE online with: https://remix.ethereum.org/vicenteherrera/starter-blockchain/blob/main/examples/solidity/VicenteCoin.sol

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract VicenteCoin is ERC20, ERC20Permit {
    constructor(uint256 initialSupply) ERC20("VicenteCoin", "VCC") ERC20Permit("VicenteCoin") {
        _mint(msg.sender, initialSupply);
    }   
}

// Deployed in Sepolia at: 0xad261586F4eD2f93185630D4F2f9a9DD02Ac72C2
// Ethereum Mainnet estimated total fee: 0.02461412 Eth
