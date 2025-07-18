// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenBadge is ERC721URIStorage, Ownable {
    uint256 private tokenIdCounter;

    mapping(address => bool) public hasBadge;

    constructor() ERC721("TokenBadge", "TBADGE") Ownable(msg.sender) {}

    function awardBadge(address recipient, string memory tokenURI) public onlyOwner {
        require(!hasBadge[recipient], "Recipient already has a badge");
        tokenIdCounter++;
        _safeMint(recipient, tokenIdCounter);
        _setTokenURI(tokenIdCounter, tokenURI);
        hasBadge[recipient] = true;
    }

    function revokeBadge(uint256 tokenId) public onlyOwner {
        address owner = ownerOf(tokenId);
        _burn(tokenId);
        hasBadge[owner] = false;
    }

    function badgeOwned(address user) external view returns (bool) {
        return hasBadge[user];
    }
}
