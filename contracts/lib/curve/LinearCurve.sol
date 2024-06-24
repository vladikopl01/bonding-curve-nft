// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {InterfaceDetection} from "@animoca/ethereum-contracts/contracts/introspection/InterfaceDetection.sol";
import {ContractOwnership} from "@animoca/ethereum-contracts/contracts/access/ContractOwnership.sol";
import {LinearCurveBase} from "./base/LinearCurveBase.sol";
import {LinearCurveStorage} from "./libraries/LinearCurveStorage.sol";

contract LinearCurve is LinearCurveBase, InterfaceDetection, ContractOwnership {
    using LinearCurveStorage for LinearCurveStorage.Layout;

    constructor(uint256 price, uint256 numerator, uint256 denominator) ContractOwnership(_msgSender()) {
        LinearCurveStorage.layout().constructorInit(price, numerator, denominator, _msgSender());
    }
}
