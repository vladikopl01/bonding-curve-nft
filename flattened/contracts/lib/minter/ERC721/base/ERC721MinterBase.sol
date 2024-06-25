// Sources flattened with hardhat v2.22.5 https://hardhat.org

// SPDX-License-Identifier: MIT

// File @animoca/ethereum-contracts/contracts/introspection/errors/InterfaceDetectionErrors.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Thrown when setting the illegal interfaceId 0xffffffff.
error IllegalInterfaceId();


// File @animoca/ethereum-contracts/contracts/introspection/interfaces/IERC165.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @title ERC165 Interface Detection Standard.
/// @dev See https://eips.ethereum.org/EIPS/eip-165.
/// @dev Note: The ERC-165 identifier for this interface is 0x01ffc9a7.
interface IERC165 {
    /// @notice Returns whether this contract implements a given interface.
    /// @dev Note: This function call must use less than 30 000 gas.
    /// @param interfaceId the interface identifier to test.
    /// @return supported True if the interface is supported, false if `interfaceId` is `0xffffffff` or if the interface is not supported.
    function supportsInterface(bytes4 interfaceId) external view returns (bool supported);
}


// File @animoca/ethereum-contracts/contracts/introspection/libraries/InterfaceDetectionStorage.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;


library InterfaceDetectionStorage {
    struct Layout {
        mapping(bytes4 => bool) supportedInterfaces;
    }

    bytes32 internal constant LAYOUT_STORAGE_SLOT = bytes32(uint256(keccak256("animoca.core.introspection.InterfaceDetection.storage")) - 1);

    bytes4 internal constant ILLEGAL_INTERFACE_ID = 0xffffffff;

    /// @notice Sets or unsets an ERC165 interface.
    /// @dev Revertswith {IllegalInterfaceId} if `interfaceId` is `0xffffffff`.
    /// @param interfaceId the interface identifier.
    /// @param supported True to set the interface, false to unset it.
    function setSupportedInterface(Layout storage s, bytes4 interfaceId, bool supported) internal {
        if (interfaceId == ILLEGAL_INTERFACE_ID) revert IllegalInterfaceId();
        s.supportedInterfaces[interfaceId] = supported;
    }

    /// @notice Returns whether this contract implements a given interface.
    /// @dev Note: This function call must use less than 30 000 gas.
    /// @param interfaceId The interface identifier to test.
    /// @return supported True if the interface is supported, false if `interfaceId` is `0xffffffff` or if the interface is not supported.
    function supportsInterface(Layout storage s, bytes4 interfaceId) internal view returns (bool supported) {
        if (interfaceId == ILLEGAL_INTERFACE_ID) {
            return false;
        }
        if (interfaceId == type(IERC165).interfaceId) {
            return true;
        }
        return s.supportedInterfaces[interfaceId];
    }

    function layout() internal pure returns (Layout storage s) {
        bytes32 position = LAYOUT_STORAGE_SLOT;
        assembly {
            s.slot := position
        }
    }
}


// File @animoca/ethereum-contracts/contracts/proxy/errors/ProxyInitializationErrors.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Emitted when trying to set a phase value that has already been reached.
/// @param currentPhase The current phase.
/// @param newPhase The new phase trying to be set.
error InitializationPhaseAlreadyReached(uint256 currentPhase, uint256 newPhase);


// File @openzeppelin/contracts/utils/StorageSlot.sol@v4.9.6

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (utils/StorageSlot.sol)
// This file was procedurally generated from scripts/generate/templates/StorageSlot.js.

pragma solidity ^0.8.0;

/**
 * @dev Library for reading and writing primitive types to specific storage slots.
 *
 * Storage slots are often used to avoid storage conflict when dealing with upgradeable contracts.
 * This library helps with reading and writing to such slots without the need for inline assembly.
 *
 * The functions in this library return Slot structs that contain a `value` member that can be used to read or write.
 *
 * Example usage to set ERC1967 implementation slot:
 * ```solidity
 * contract ERC1967 {
 *     bytes32 internal constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
 *
 *     function _getImplementation() internal view returns (address) {
 *         return StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value;
 *     }
 *
 *     function _setImplementation(address newImplementation) internal {
 *         require(Address.isContract(newImplementation), "ERC1967: new implementation is not a contract");
 *         StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value = newImplementation;
 *     }
 * }
 * ```
 *
 * _Available since v4.1 for `address`, `bool`, `bytes32`, `uint256`._
 * _Available since v4.9 for `string`, `bytes`._
 */
library StorageSlot {
    struct AddressSlot {
        address value;
    }

    struct BooleanSlot {
        bool value;
    }

    struct Bytes32Slot {
        bytes32 value;
    }

    struct Uint256Slot {
        uint256 value;
    }

    struct StringSlot {
        string value;
    }

    struct BytesSlot {
        bytes value;
    }

    /**
     * @dev Returns an `AddressSlot` with member `value` located at `slot`.
     */
    function getAddressSlot(bytes32 slot) internal pure returns (AddressSlot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `BooleanSlot` with member `value` located at `slot`.
     */
    function getBooleanSlot(bytes32 slot) internal pure returns (BooleanSlot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `Bytes32Slot` with member `value` located at `slot`.
     */
    function getBytes32Slot(bytes32 slot) internal pure returns (Bytes32Slot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `Uint256Slot` with member `value` located at `slot`.
     */
    function getUint256Slot(bytes32 slot) internal pure returns (Uint256Slot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `StringSlot` with member `value` located at `slot`.
     */
    function getStringSlot(bytes32 slot) internal pure returns (StringSlot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `StringSlot` representation of the string storage pointer `store`.
     */
    function getStringSlot(string storage store) internal pure returns (StringSlot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := store.slot
        }
    }

    /**
     * @dev Returns an `BytesSlot` with member `value` located at `slot`.
     */
    function getBytesSlot(bytes32 slot) internal pure returns (BytesSlot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `BytesSlot` representation of the bytes storage pointer `store`.
     */
    function getBytesSlot(bytes storage store) internal pure returns (BytesSlot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := store.slot
        }
    }
}


// File @animoca/ethereum-contracts/contracts/proxy/libraries/ProxyInitialization.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;


/// @notice Multiple calls protection for storage-modifying proxy initialization functions.
library ProxyInitialization {
    /// @notice Sets the initialization phase during a storage-modifying proxy initialization function.
    /// @dev Reverts with {InitializationPhaseAlreadyReached} if `phase` has been reached already.
    /// @param storageSlot the storage slot where `phase` is stored.
    /// @param phase the initialization phase.
    function setPhase(bytes32 storageSlot, uint256 phase) internal {
        StorageSlot.Uint256Slot storage currentVersion = StorageSlot.getUint256Slot(storageSlot);
        uint256 currentPhase = currentVersion.value;
        if (currentPhase >= phase) revert InitializationPhaseAlreadyReached(currentPhase, phase);
        currentVersion.value = phase;
    }
}


// File contracts/lib/minter/ERC721/interfaces/IERC721Minter.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @title ERC721 Minter interface for minting ERC721 tokens.
/// @dev Note: The ERC-165 identifier for this interface is 0x4f859546.
interface IERC721Minter {
    /// @notice Returns the current token ID.
    /// @return tokenId The current token ID.
    function currentTokenId() external view returns (uint256 tokenId);

    /// @notice Returns the maximum token ID.
    /// @return tokenId The maximum token ID.
    function maxTokenId() external view returns (uint256 tokenId);

    /// @notice Mints a token to the specified address.
    /// @param to The address to receive the token.
    function mint(address to) external;
}


// File @animoca/ethereum-contracts/contracts/token/ERC721/interfaces/IERC721Mintable.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @title ERC721 Non-Fungible Token Standard, optional extension: Mintable.
/// @dev See https://eips.ethereum.org/EIPS/eip-721
/// @dev Note: The ERC-165 identifier for this interface is 0x8e773e13.
interface IERC721Mintable {
    /// @notice Unsafely mints a token.
    /// @dev Reverts if `to` is the zero address.
    /// @dev Reverts if `tokenId` already exists.
    /// @dev Emits an {IERC721-Transfer} event from the zero address.
    /// @param to Address of the new token owner.
    /// @param tokenId Identifier of the token to mint.
    function mint(address to, uint256 tokenId) external;

    /// @notice Safely mints a token.
    /// @dev Reverts if `to` is the zero address.
    /// @dev Reverts if `tokenId` already exists.
    /// @dev Reverts if `to` is a contract and the call to {IERC721Receiver-onERC721Received} fails, reverts or is rejected.
    /// @dev Emits an {IERC721-Transfer} event from the zero address.
    /// @param to Address of the new token owner.
    /// @param tokenId Identifier of the token to mint.
    /// @param data Optional data to pass along to the receiver call.
    function safeMint(address to, uint256 tokenId, bytes calldata data) external;

    /// @notice Unsafely mints a batch of tokens.
    /// @dev Reverts if `to` is the zero address.
    /// @dev Reverts if one of `tokenIds` already exists.
    /// @dev Emits an {IERC721-Transfer} event from the zero address for each of `tokenIds`.
    /// @param to Address of the new tokens owner.
    /// @param tokenIds Identifiers of the tokens to mint.
    function batchMint(address to, uint256[] calldata tokenIds) external;
}


// File contracts/lib/minter/ERC721/errors/ERC721MinterErrors.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Thrown when the token ID is zero.
error ERC721MinterZeroMaxTokenId();

/// @notice Thrown when the token address is zero.
error ERC721MinterZeroTokenAddress();

/// @notice Thrown when the token contract interface id does not supported.
error ERC721MinterUnsupportedContractType(address tokenContract);

/// @notice Thrown when the maximum token ID is exceeded.
error ERC721MinterMaxTokenIdExceeded();


// File contracts/lib/minter/ERC721/libraries/ERC721MinterStorage.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

// solhint-disable-next-line max-line-length






library ERC721MinterStorage {
    using ERC721MinterStorage for ERC721MinterStorage.Layout;
    using InterfaceDetectionStorage for InterfaceDetectionStorage.Layout;

    struct Layout {
        uint256 currentTokenId;
        uint256 maxTokenId;
        IERC721Mintable token;
    }

    bytes32 internal constant LAYOUT_STORAGE_SLOT = bytes32(uint256(keccak256("yura2100.token.ERC721.ERC721Minter.storage")) - 1);
    bytes32 internal constant PROXY_INIT_PHASE_SLOT = bytes32(uint256(keccak256("yura2100.token.ERC721.ERC721Minter.phase")) - 1);

    /// @notice Initializes the storage with the maximum token ID and the ERC721 token contract.
    /// @notice Marks the following ERC165 interfaces as supported: ERC721Minter.
    /// @dev Note: This function should be called ONLY in the constructor of an immutable (non-proxied) contract.
    /// @dev Reverts with {ERC721MinterZeroMaxTokenId} if the `maxTokenId` is zero.
    /// @dev Reverts with {ERC721MinterZeroTokenAddress} if the `token` is the zero address.
    /// @dev Reverts with {ERC721MinterUnsupportedContractType} if the `token` does not support the IERC721Mintable interface.
    /// @param maxTokenId The maximum token ID that can be minted.
    /// @param token The ERC721 token contract.
    function constructorInit(Layout storage s, uint256 maxTokenId, IERC721Mintable token) internal {
        if (maxTokenId == 0) {
            revert ERC721MinterZeroMaxTokenId();
        }
        if (address(token) == address(0)) {
            revert ERC721MinterZeroTokenAddress();
        }

        if (!IERC165(address(token)).supportsInterface(type(IERC721Mintable).interfaceId)) {
            revert ERC721MinterUnsupportedContractType(address(token));
        }
        s.maxTokenId = maxTokenId;
        s.token = token;
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC721Minter).interfaceId, true);
    }

    /// @notice Initializes the storage with the maximum token ID and the ERC721 token contract.
    /// @notice Sets the proxy initialization phase to `1`.
    /// @notice Marks the following ERC165 interfaces as supported: ERC721Minter.
    /// @dev Note: This function should be called ONLY in the init function of a proxied contract.
    /// @dev Reverts with {InitializationPhaseAlreadyReached} if the proxy initialization phase is set to `1` or above.
    /// @param maxTokenId The maximum token ID that can be minted.
    /// @param token The ERC721 token contract.
    function proxyInit(Layout storage s, uint256 maxTokenId, IERC721Mintable token) internal {
        ProxyInitialization.setPhase(PROXY_INIT_PHASE_SLOT, 1);
        s.constructorInit(maxTokenId, token);
    }

    /// @notice Mints a token to the specified address.
    /// @dev Reverts with {ERC721MinterMaxTokenIdExceeded} if the current token ID exceeds the maximum token ID.
    /// @param to The address to which the token will be minted.
    function mint(Layout storage s, address to) internal {
        uint256 nextId = s.currentTokenId + 1;
        if (nextId > s.maxTokenId) {
            revert ERC721MinterMaxTokenIdExceeded();
        }
        s.token.mint(to, nextId);
        s.currentTokenId = nextId;
    }

    /// @notice Returns the current token ID.
    /// @return tokenId The current token ID.
    function currentId(Layout storage s) internal view returns (uint256 tokenId) {
        return s.currentTokenId;
    }

    /// @notice Returns the maximum token ID.
    /// @return tokenId The maximum token ID.
    function maxId(Layout storage s) internal view returns (uint256 tokenId) {
        return s.maxTokenId;
    }

    function layout() internal pure returns (Layout storage s) {
        bytes32 position = LAYOUT_STORAGE_SLOT;
        assembly {
            s.slot := position
        }
    }
}


// File contracts/lib/minter/ERC721/base/ERC721MinterBase.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;


/// @title ERC721 Minter contract for minting ERC721 tokens with a maximum token ID limit.
/// @dev This contract is to be used via inheritance in a proxied implementation.
/// @dev Note: This contract requires ERC165 (Interface Detection Standard).
abstract contract ERC721MinterBase is IERC721Minter {
    using ERC721MinterStorage for ERC721MinterStorage.Layout;

    /// @inheritdoc IERC721Minter
    function mint(address to) public virtual {
        ERC721MinterStorage.layout().mint(to);
    }

    /// @inheritdoc IERC721Minter
    function currentTokenId() public view returns (uint256 tokenId) {
        return ERC721MinterStorage.layout().currentId();
    }

    /// @inheritdoc IERC721Minter
    function maxTokenId() public view returns (uint256 tokenId) {
        return ERC721MinterStorage.layout().maxId();
    }
}