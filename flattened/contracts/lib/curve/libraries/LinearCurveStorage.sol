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


// File contracts/lib/curve/errors/LinearCurveErrors.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Thrown when the numerator of the linear curve is zero.
error LinearCurveZeroNumerator();

/// @notice Thrown when the denominator of the linear curve is zero.
error LinearCurveZeroDenominator();


// File contracts/lib/curve/events/LinearCurveEvents.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Emitted when the initial price of the curve is set.
/// @param price The initial price.
/// @param operator The address setting the initial price.
event InitialPriceSet(uint256 indexed price, address indexed operator);

/// @notice Emitted when the slope numerator of the curve is set.
/// @param numerator The slope numerator.
/// @param operator The address setting the slope numerator.
event SlopeNumeratorSet(uint256 indexed numerator, address indexed operator);

/// @notice Emitted when the slope denominator of the curve is set.
/// @param denominator The slope denominator.
/// @param operator The address setting the slope denominator.
event SlopeDenominatorSet(uint256 indexed denominator, address indexed operator);


// File contracts/lib/curve/interfaces/ICurve.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @title Curve interface for calculating the price of a token.
/// @dev The curve is defined by the price function `calculatePrice`.
/// @dev Note: The ERC-165 identifier for this interface is 0xa6413a27.
interface ICurve {
    /// @notice Calculates the price of a token given the total supply and the amount to mint.
    /// @dev The price is calculated based on bonding curve mathematical function.
    /// @param totalSupply The total supply of the tokens.
    /// @param amount The amount of tokens to mint.
    function calculatePrice(uint256 totalSupply, uint256 amount) external view returns (uint256 price);
}


// File contracts/lib/curve/interfaces/ILinearCurve.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @title Linear Curve interface for calculating the price of a token.
/// @dev The curve is defined by the price function `calculatePrice` in {ICurve} interface.
/// @dev Note: The ERC-165 identifier for this interface is 0x0e098596.
interface ILinearCurve {
    /// @notice Returns the initial price of the curve.
    /// @return price The initial price.
    function initialPrice() external view returns (uint256 price);

    /// @notice Returns the slope numerator of the curve.
    /// @return numerator The slope numerator.
    function slopeNumerator() external view returns (uint256 numerator);

    /// @notice Returns the slope denominator of the curve.
    /// @return denominator The slope denominator.
    function slopeDenominator() external view returns (uint256 denominator);

    /// @notice Sets the initial price of the curve.
    /// @dev Emits a {InitialPriceSet} event.
    /// @param price The initial price.
    function setInitialPrice(uint256 price) external;

    /// @notice Sets the slope numerator of the curve.
    /// @dev Reverts if `numerator` is zero.
    /// @dev Emits a {SlopeNumeratorSet} event.
    /// @param numerator The slope numerator.
    function setSlopeNumerator(uint256 numerator) external;

    /// @notice Sets the slope denominator of the curve.
    /// @dev Reverts if `denominator` is zero.
    /// @dev Emits a {SlopeDenominatorSet} event.
    /// @param denominator The slope denominator.
    function setSlopeDenominator(uint256 denominator) external;
}


// File contracts/lib/curve/libraries/LinearCurveStorage.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;






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

    /// @notice Initializes the storage with an initial price, slope numerator, and slope denominator (immutable version).
    /// @notice Marks the following ERC165 interface(s) as supported: ICurve, ILinearCurve.
    /// @dev Note: This function should be called ONLY in the constructor of an immutable (non-proxied) contract.
    /// @dev Emits an {InitialPriceSet}.
    /// @dev Emits a {SlopeNumeratorSet} if `numerator` is not zero.
    /// @dev Emits a {SlopeDenominatorSet} if `denominator` is not zero.
    /// @param price The initial price.
    /// @param numerator The slope numerator.
    /// @param denominator The slope denominator.
    /// @param operator The address of the operator performing the initialization.
    function constructorInit(Layout storage s, uint256 price, uint256 numerator, uint256 denominator, address operator) internal {
        s.setInitialPrice(price, operator);
        s.setSlopeNumerator(numerator, operator);
        s.setSlopeDenominator(denominator, operator);
        InterfaceDetectionStorage.layout().setSupportedInterface(type(ICurve).interfaceId, true);
        InterfaceDetectionStorage.layout().setSupportedInterface(type(ILinearCurve).interfaceId, true);
    }

    /// @notice Initializes the storage with an initial price, slope numerator, and slope denominator (proxied version).
    /// @notice Sets the proxy initialization phase to `1`.
    /// @notice Marks the following ERC165 interface(s) as supported: ICurve, ILinearCurve.
    /// @dev Note: This function should be called ONLY in the init function of a proxied contract.
    /// @dev Reverts with {InitializationPhaseAlreadyReached} if the proxy initialization phase is set to `1` or above.
    /// @dev Emits an {InitialPriceSet}.
    /// @dev Emits a {SlopeNumeratorSet} if `numerator` is not zero.
    /// @dev Emits a {SlopeDenominatorSet} if `denominator` is not zero.
    /// @param price The initial price.
    /// @param numerator The slope numerator.
    /// @param denominator The slope denominator.
    function proxyInit(Layout storage s, uint256 price, uint256 numerator, uint256 denominator, address operator) internal {
        ProxyInitialization.setPhase(PROXY_INIT_PHASE_SLOT, 1);
        s.constructorInit(price, numerator, denominator, operator);
    }

    /// @notice Sets the initial price of the curve.
    /// @dev Emits a {InitialPriceSet} event.
    /// @param price The initial price.
    /// @param operator The address of the operator performing the operation.
    function setInitialPrice(Layout storage s, uint256 price, address operator) internal {
        s.price = price;
        emit InitialPriceSet(price, operator);
    }

    /// @notice Sets the slope numerator of the curve.
    /// @dev Reverts with {LinearCurveZeroNumerator} if `numerator` is zero.
    /// @dev Emits a {SlopeNumeratorSet} event.
    /// @param numerator The slope numerator.
    /// @param operator The address of the operator performing the operation.
    function setSlopeNumerator(Layout storage s, uint256 numerator, address operator) internal {
        if (numerator == 0) {
            revert LinearCurveZeroNumerator();
        }

        s.numerator = numerator;
        emit SlopeNumeratorSet(numerator, operator);
    }

    /// @notice Sets the slope denominator of the curve.
    /// @dev Reverts with {LinearCurveZeroDenominator} if `denominator` is zero.
    /// @dev Emits a {SlopeDenominatorSet} event.
    /// @param denominator The slope denominator.
    /// @param operator The address of the operator performing the operation.
    function setSlopeDenominator(Layout storage s, uint256 denominator, address operator) internal {
        if (denominator == 0) {
            revert LinearCurveZeroDenominator();
        }

        s.denominator = denominator;
        emit SlopeDenominatorSet(denominator, operator);
    }

    /// @notice Calculates the price of a token given the total supply and the amount to mint.
    /// @param totalSupply The total supply of the tokens.
    /// @param amount The amount to mint.
    /// @return price The price of the token.
    function calculatePrice(Layout storage s, uint256 totalSupply, uint256 amount) internal view returns (uint256 price) {
        uint256 newSupply = totalSupply + amount - 1;
        return s.price + (newSupply * s.numerator) / s.denominator;
    }

    /// @notice Returns the initial price of the curve.
    /// @return price The initial price.
    function initialPrice(Layout storage s) internal view returns (uint256 price) {
        return s.price;
    }

    /// @notice Returns the slope numerator of the curve.
    /// @return numerator The slope numerator.
    function slopeNumerator(Layout storage s) internal view returns (uint256 numerator) {
        return s.numerator;
    }

    /// @notice Returns the slope denominator of the curve.
    /// @return denominator The slope denominator.
    function slopeDenominator(Layout storage s) internal view returns (uint256 denominator) {
        return s.denominator;
    }

    function layout() internal pure returns (Layout storage s) {
        bytes32 position = LAYOUT_STORAGE_SLOT;
        assembly {
            s.slot := position
        }
    }
}