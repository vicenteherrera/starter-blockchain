// SPDX-License-Identifier: MIT
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


