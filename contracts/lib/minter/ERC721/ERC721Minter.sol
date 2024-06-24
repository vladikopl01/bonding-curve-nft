// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {InterfaceDetection} from "@animoca/ethereum-contracts/contracts/introspection/InterfaceDetection.sol";
import {IERC721Mintable} from "@animoca/ethereum-contracts/contracts/token/ERC721/interfaces/IERC721Mintable.sol";
import {ERC721MinterBase} from "./base/ERC721MinterBase.sol";
import {ERC721MinterStorage} from "./libraries/ERC721MinterStorage.sol";

contract ERC721Minter is ERC721MinterBase, InterfaceDetection {
    using ERC721MinterStorage for ERC721MinterStorage.Layout;

    constructor(uint256 maxTokenId, IERC721Mintable token) {
        ERC721MinterStorage.layout().constructorInit(maxTokenId, token);
    }
}
