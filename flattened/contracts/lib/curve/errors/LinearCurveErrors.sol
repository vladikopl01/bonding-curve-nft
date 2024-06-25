// Sources flattened with hardhat v2.22.5 https://hardhat.org

// SPDX-License-Identifier: MIT

// File contracts/lib/curve/errors/LinearCurveErrors.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Thrown when the numerator of the linear curve is zero.
error LinearCurveZeroNumerator();

/// @notice Thrown when the denominator of the linear curve is zero.
error LinearCurveZeroDenominator();