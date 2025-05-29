/*
NFT Royalties

Use case: Ensure creators are paid every time their work is resold.
Blockchain advantage: Automatic enforcement of royalty payments.
Example: NFT contract (ERC-721 or ERC-1155) with secondary sale hooks and royalty logic.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract RoyaltyNFT is ERC721 {
    address public creator;
    uint256 public royaltyPercent; // e.g., 5 for 5%

    constructor() ERC721("RoyaltyNFT", "RFT") {
        creator = msg.sender;
        royaltyPercent = 5;
    }

    function _transfer(address from, address to, uint256 tokenId) internal override {
        uint256 royalty = (msg.value * royaltyPercent) / 100;
        payable(creator).transfer(royalty);
        super._transfer(from, to, tokenId);
    }
}