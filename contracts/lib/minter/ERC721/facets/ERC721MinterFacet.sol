// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForwarderRegistryContextBase} from "@animoca/ethereum-contracts/contracts/metatx/base/ForwarderRegistryContextBase.sol";
import {IForwarderRegistry} from "@animoca/ethereum-contracts/contracts/metatx/interfaces/IForwarderRegistry.sol";
import {ProxyAdminStorage} from "@animoca/ethereum-contracts/contracts/proxy/libraries/ProxyAdminStorage.sol";
import {IERC721Mintable} from "@animoca/ethereum-contracts/contracts/token/ERC721/interfaces/IERC721Mintable.sol";
import {ERC721MinterBase} from "../base/ERC721MinterBase.sol";
import {ERC721MinterStorage} from "../libraries/ERC721MinterStorage.sol";

contract ERC721MinterFacet is ERC721MinterBase, ForwarderRegistryContextBase {
    using ERC721MinterStorage for ERC721MinterStorage.Layout;
    using ProxyAdminStorage for ProxyAdminStorage.Layout;

    constructor(IForwarderRegistry forwarderRegistry) ForwarderRegistryContextBase(forwarderRegistry) {}

    function initERC721MinterStorage(uint256 maxTokenId, IERC721Mintable token) external {
        ProxyAdminStorage.layout().enforceIsProxyAdmin(_msgSender());
        ERC721MinterStorage.layout().proxyInit(maxTokenId, token);
    }
}
