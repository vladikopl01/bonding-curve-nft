// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Context} from "@openzeppelin/contracts/utils/Context.sol";
import {ForwarderRegistryContextBase} from "@animoca/ethereum-contracts/contracts/metatx/base/ForwarderRegistryContextBase.sol";
import {IForwarderRegistry} from "@animoca/ethereum-contracts/contracts/metatx/interfaces/IForwarderRegistry.sol";
import {ProxyAdminStorage} from "@animoca/ethereum-contracts/contracts/proxy/libraries/ProxyAdminStorage.sol";
import {LinearCurveBase} from "../base/LinearCurveBase.sol";
import {LinearCurveStorage} from "../libraries/LinearCurveStorage.sol";

contract LinearCurveFacet is LinearCurveBase, ForwarderRegistryContextBase {
    using LinearCurveStorage for LinearCurveStorage.Layout;
    using ProxyAdminStorage for ProxyAdminStorage.Layout;

    constructor(IForwarderRegistry forwarderRegistry) ForwarderRegistryContextBase(forwarderRegistry) {}

    function initLinearCurveStorage(uint256 price, uint256 numerator, uint256 denominator) external {
        address operator = _msgSender();
        ProxyAdminStorage.layout().enforceIsProxyAdmin(operator);
        LinearCurveStorage.layout().proxyInit(price, numerator, denominator, operator);
    }

    function _msgSender() internal view virtual override(Context, ForwarderRegistryContextBase) returns (address) {
        return ForwarderRegistryContextBase._msgSender();
    }

    function _msgData() internal view virtual override(Context, ForwarderRegistryContextBase) returns (bytes calldata) {
        return ForwarderRegistryContextBase._msgData();
    }
}
