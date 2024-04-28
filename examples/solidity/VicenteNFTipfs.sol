// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VicenteNFTipfs is ERC721URIStorage, Ownable(msg.sender) {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("VicenteNFTipfs", "VNI") {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://";
    }

    function mintCollectionNFT(address to, string memory metadataHash) public onlyOwner() {
        _tokenIds.increment(); // NFT IDs start at 1
        uint256 tokenId = _tokenIds.current();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, metadataHash);
    }
}

// Deployed in Sepolia at: 0x96ff94d16a5081105F9c934F4cc78640DB31a78B
// Ethereum Mainnet estimated total fee:  0.02446725ETH