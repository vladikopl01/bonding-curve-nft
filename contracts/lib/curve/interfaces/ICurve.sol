// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface ICurve {
    function calculatePrice(uint256 totalSupply, uint256 amount) external view returns (uint256 price);
}
