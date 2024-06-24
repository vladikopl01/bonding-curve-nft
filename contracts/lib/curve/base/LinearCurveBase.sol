// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ICurve} from "../interfaces/ICurve.sol";
import {ILinearCurve} from "../interfaces/ILinearCurve.sol";
import {LinearCurveStorage} from "../libraries/LinearCurveStorage.sol";
import {Context} from "@openzeppelin/contracts/utils/Context.sol";
import {ContractOwnershipStorage} from "@animoca/ethereum-contracts/contracts/access/libraries/ContractOwnershipStorage.sol";

abstract contract LinearCurveBase is ICurve, ILinearCurve, Context {
    using LinearCurveStorage for LinearCurveStorage.Layout;
    using ContractOwnershipStorage for ContractOwnershipStorage.Layout;

    function calculatePrice(uint256 totalSupply, uint256 amount) external view override returns (uint256 price) {
        return LinearCurveStorage.layout().calculatePrice(totalSupply, amount);
    }

    function initialPrice() external view override returns (uint256 price) {
        return LinearCurveStorage.layout().initialPrice();
    }

    function slopeNumerator() external view override returns (uint256 numerator) {
        return LinearCurveStorage.layout().slopeNumerator();
    }

    function slopeDenominator() external view override returns (uint256 denominator) {
        return LinearCurveStorage.layout().slopeDenominator();
    }

    function setInitialPrice(uint256 price) external override {
        address operator = _msgSender();
        ContractOwnershipStorage.layout().enforceIsContractOwner(operator);
        LinearCurveStorage.layout().setInitialPrice(price, operator);
    }

    function setSlopeNumerator(uint256 numerator) external override {
        address operator = _msgSender();
        ContractOwnershipStorage.layout().enforceIsContractOwner(operator);
        LinearCurveStorage.layout().setSlopeNumerator(numerator, operator);
    }

    function setSlopeDenominator(uint256 denominator) external override {
        address operator = _msgSender();
        ContractOwnershipStorage.layout().enforceIsContractOwner(operator);
        LinearCurveStorage.layout().setSlopeDenominator(denominator, operator);
    }
}
