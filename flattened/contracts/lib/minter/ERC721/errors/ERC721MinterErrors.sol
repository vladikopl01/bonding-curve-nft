// Sources flattened with hardhat v2.22.5 https://hardhat.org

// SPDX-License-Identifier: MIT

// File contracts/lib/minter/ERC721/errors/ERC721MinterErrors.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Thrown when the token ID is zero.
error ERC721MinterZeroMaxTokenId();

/// @notice Thrown when the token address is zero.
error ERC721MinterZeroTokenAddress();

/// @notice Thrown when the token contract interface id does not supported.
error ERC721MinterUnsupportedContractType(address tokenContract);

/// @notice Thrown when the maximum token ID is exceeded.
error ERC721MinterMaxTokenIdExceeded();