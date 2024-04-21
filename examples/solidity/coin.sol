// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MyToken is ERC20, ERC20Permit {
    constructor(uint256 initialSupply) ERC20("VicenteCoin", "VCC") ERC20Permit("VicenteCoin") {
        _mint(msg.sender, initialSupply);
    }   
}
