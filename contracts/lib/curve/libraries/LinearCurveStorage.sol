// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {InterfaceDetectionStorage} from "@animoca/ethereum-contracts/contracts/introspection/libraries/InterfaceDetectionStorage.sol";
import {ProxyInitialization} from "@animoca/ethereum-contracts/contracts/proxy/libraries/ProxyInitialization.sol";
import {ICurve} from "../interfaces/ICurve.sol";
import {ILinearCurve} from "../interfaces/ILinearCurve.sol";
import {InitialPriceSet, SlopeNumeratorSet, SlopeDenominatorSet} from "../events/LinearCurveEvents.sol";
import {LinearCurveZeroValue} from "../errors/LinearCurveErrors.sol";

library LinearCurveStorage {
    using LinearCurveStorage for LinearCurveStorage.Layout;
    using InterfaceDetectionStorage for InterfaceDetectionStorage.Layout;

    struct Layout {
        uint256 price;
        uint256 numerator;
        uint256 denominator;
    }

    bytes32 internal constant LAYOUT_STORAGE_SLOT = bytes32(uint256(keccak256("yura2100.curve.LinearCurve.storage")) - 1);
    bytes32 internal constant PROXY_INIT_PHASE_SLOT = bytes32(uint256(keccak256("yura2100.curve.LinearCurve.phase")) - 1);

    function constructorInit(Layout storage s, uint256 price, uint256 numerator, uint256 denominator, address operator) internal {
        s.setInitialPrice(price, operator);
        s.setSlopeNumerator(numerator, operator);
        s.setSlopeDenominator(denominator, operator);
        InterfaceDetectionStorage.layout().setSupportedInterface(type(ICurve).interfaceId, true);
        InterfaceDetectionStorage.layout().setSupportedInterface(type(ILinearCurve).interfaceId, true);
    }

    function proxyInit(Layout storage s, uint256 price, uint256 numerator, uint256 denominator, address operator) internal {
        ProxyInitialization.setPhase(PROXY_INIT_PHASE_SLOT, 1);
        s.constructorInit(price, numerator, denominator, operator);
    }

    function calculatePrice(Layout storage s, uint256 totalSupply, uint256 amount) internal view returns (uint256 price) {
        uint256 newSupply = totalSupply + amount - 1;
        return s.price + (newSupply * s.numerator) / s.denominator;
    }

    function initialPrice(Layout storage s) internal view returns (uint256 price) {
        return s.price;
    }

    function slopeNumerator(Layout storage s) internal view returns (uint256 numerator) {
        return s.numerator;
    }

    function slopeDenominator(Layout storage s) internal view returns (uint256 denominator) {
        return s.denominator;
    }

    function setInitialPrice(Layout storage s, uint256 price, address operator) internal {
        s.price = price;
        emit InitialPriceSet(price, operator);
    }

    function setSlopeNumerator(Layout storage s, uint256 numerator, address operator) internal {
        if (numerator == 0) {
            revert LinearCurveZeroValue();
        }

        s.numerator = numerator;
        emit SlopeNumeratorSet(numerator, operator);
    }

    function setSlopeDenominator(Layout storage s, uint256 denominator, address operator) internal {
        if (denominator == 0) {
            revert LinearCurveZeroValue();
        }

        s.denominator = denominator;
        emit SlopeDenominatorSet(denominator, operator);
    }

    function layout() internal pure returns (Layout storage s) {
        bytes32 position = LAYOUT_STORAGE_SLOT;
        assembly {
            s.slot := position
        }
    }
}
