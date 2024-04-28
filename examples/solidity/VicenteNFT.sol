// SPDX-License-Identifier: MIT

// Open in Remix IDE online with: https://remix.ethereum.org/vicenteherrera/starter-blockchain/blob/main/examples/solidity/VicenteNFT.sol

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VicenteNFT is ERC721, Ownable {
    uint256 _nextTokenId;

    constructor() ERC721("VicenteNFT", "NFT") Ownable(msg.sender) {
        _nextTokenId = 1;
    }
    
    function _baseURI() internal pure override returns (string memory) {
        return "https://vicenteherrera.com/nft/";
    }

    function mint(address to) public onlyOwner {
        _safeMint(to, _nextTokenId, "");
        _nextTokenId++;
    }

}

// Deployed in Sepolia at: 0x57a453a3dDFbbe7bA06E99cc8c9eF547529dAC0D
// Ethereum Mainnet estimated total fee: 0.02413305 Eth
