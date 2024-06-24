// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IERC721Minter {
    function currentId() external view returns (uint256 tokenId);

    function maxId() external view returns (uint256 tokenId);

    function mint(address to) external;
}
