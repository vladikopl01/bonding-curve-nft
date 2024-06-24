// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface ILinearCurve {
    function initialPrice() external view returns (uint256 price);

    function slopeNumerator() external view returns (uint256 numerator);

    function slopeDenominator() external view returns (uint256 denominator);

    function setInitialPrice(uint256 price) external;

    function setSlopeNumerator(uint256 numerator) external;

    function setSlopeDenominator(uint256 denominator) external;
}
