// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {InterfaceDetectionStorage} from "@animoca/ethereum-contracts/contracts/introspection/libraries/InterfaceDetectionStorage.sol";
import {IERC165} from "@animoca/ethereum-contracts/contracts/introspection/interfaces/IERC165.sol";
import {IERC721Mintable} from "@animoca/ethereum-contracts/contracts/token/ERC721/interfaces/IERC721Mintable.sol";
import {ProxyInitialization} from "@animoca/ethereum-contracts/contracts/proxy/libraries/ProxyInitialization.sol";
import {IERC721Minter} from "../interfaces/IERC721Minter.sol";
import {ERC721MinterZeroValue, ERC721MinterIncorrectTokenContractType, ERC721MinterMaxTokenId} from "../errors/ERC721MinterErrors.sol";

library ERC721MinterStorage {
    using ERC721MinterStorage for ERC721MinterStorage.Layout;
    using InterfaceDetectionStorage for InterfaceDetectionStorage.Layout;

    struct Layout {
        uint256 currentTokenId;
        uint256 maxTokenId;
        IERC721Mintable token;
    }

    bytes32 internal constant LAYOUT_STORAGE_SLOT = bytes32(uint256(keccak256("yura2100.minter.ERC721.ERC721Minter.storage")) - 1);
    bytes32 internal constant PROXY_INIT_PHASE_SLOT = bytes32(uint256(keccak256("yura2100.minter.ERC721.ERC721Minter.phase")) - 1);

    function constructorInit(Layout storage s, uint256 maxTokenId, IERC721Mintable token) internal {
        if (maxTokenId == 0) {
            revert ERC721MinterZeroValue();
        }
        if (!IERC165(address(token)).supportsInterface(type(IERC721Mintable).interfaceId)) {
            revert ERC721MinterIncorrectTokenContractType(address(token));
        }
        s.maxTokenId = maxTokenId;
        s.token = token;
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC721Minter).interfaceId, true);
    }

    function proxyInit(Layout storage s, uint256 maxTokenId, IERC721Mintable token) internal {
        ProxyInitialization.setPhase(PROXY_INIT_PHASE_SLOT, 1);
        s.constructorInit(maxTokenId, token);
    }

    function currentId(Layout storage s) internal view returns (uint256 tokenId) {
        return s.currentTokenId;
    }

    function maxId(Layout storage s) internal view returns (uint256 tokenId) {
        return s.maxTokenId;
    }

    function mint(Layout storage s, address to) internal {
        uint256 nextId = s.currentTokenId + 1;
        if (nextId > s.maxTokenId) {
            revert ERC721MinterMaxTokenId();
        }
        s.token.mint(to, nextId);
        s.currentTokenId = nextId;
    }

    function layout() internal pure returns (Layout storage s) {
        bytes32 position = LAYOUT_STORAGE_SLOT;
        assembly {
            s.slot := position
        }
    }
}
