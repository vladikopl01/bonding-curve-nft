// Sources flattened with hardhat v2.22.5 https://hardhat.org

// SPDX-License-Identifier: MIT

// File @animoca/ethereum-contracts/contracts/access/errors/Common.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Thrown when the target contract is actually not a contract.
/// @param targetContract The contract that was checked
error TargetIsNotAContract(address targetContract);


// File @animoca/ethereum-contracts/contracts/access/errors/ContractOwnershipErrors.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Thrown when an account is not the contract owner but is required to.
/// @param account The account that was checked.
error NotContractOwner(address account);

/// @notice Thrown when an account is not the pending contract owner but is required to.
/// @param account The account that was checked.
error NotPendingContractOwner(address account);

/// @notice Thrown when an account is not the target contract owner but is required to.
/// @param targetContract The contract that was checked.
/// @param account The account that was checked.
error NotTargetContractOwner(address targetContract, address account);


// File @animoca/ethereum-contracts/contracts/access/events/ERC173Events.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Emitted when the contract ownership changes.
/// @param previousOwner the previous contract owner.
/// @param newOwner the new contract owner.
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

/// @notice Emitted when a new contract owner is pending.
/// @param pendingOwner the address of the new contract owner.
event OwnershipTransferPending(address indexed pendingOwner);


// File @animoca/ethereum-contracts/contracts/access/interfaces/IERC173.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @title ERC-173 Contract Ownership Standard (functions)
/// @dev See https://eips.ethereum.org/EIPS/eip-173
/// @dev Note: the ERC-165 identifier for this interface is 0x7f5828d0
interface IERC173 {
    /// @notice Sets the address of the new contract owner.
    /// @dev Reverts if the sender is not the contract owner.
    /// @dev Emits an {OwnershipTransferred} event if `newOwner` is different from the current contract owner.
    /// @param newOwner The address of the new contract owner. Using the zero address means renouncing ownership.
    function transferOwnership(address newOwner) external;

    /// @notice Gets the address of the contract owner.
    /// @return contractOwner The address of the contract owner.
    function owner() external view returns (address contractOwner);
}


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


// File @openzeppelin/contracts/utils/Address.sol@v4.9.6

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (utils/Address.sol)

pragma solidity ^0.8.1;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     *
     * Furthermore, `isContract` will also return true if the target contract within
     * the same transaction is already scheduled for destruction by `SELFDESTRUCT`,
     * which only has an effect at the end of a transaction.
     * ====
     *
     * [IMPORTANT]
     * ====
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://consensys.net/diligence/blog/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.8.0/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verify that a low level call to smart-contract was successful, and revert (either by bubbling
     * the revert reason or using the provided one) in case of unsuccessful call or if target was not a contract.
     *
     * _Available since v4.8._
     */
    function verifyCallResultFromTarget(
        address target,
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        if (success) {
            if (returndata.length == 0) {
                // only check isContract if the call was successful and the return data is empty
                // otherwise we already know that it was a contract
                require(isContract(target), "Address: call to non-contract");
            }
            return returndata;
        } else {
            _revert(returndata, errorMessage);
        }
    }

    /**
     * @dev Tool to verify that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason or using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            _revert(returndata, errorMessage);
        }
    }

    function _revert(bytes memory returndata, string memory errorMessage) private pure {
        // Look for revert reason and bubble it up if present
        if (returndata.length > 0) {
            // The easiest way to bubble the revert reason is using memory via assembly
            /// @solidity memory-safe-assembly
            assembly {
                let returndata_size := mload(returndata)
                revert(add(32, returndata), returndata_size)
            }
        } else {
            revert(errorMessage);
        }
    }
}


// File @animoca/ethereum-contracts/contracts/access/libraries/ContractOwnershipStorage.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;







library ContractOwnershipStorage {
    using Address for address;
    using ContractOwnershipStorage for ContractOwnershipStorage.Layout;
    using InterfaceDetectionStorage for InterfaceDetectionStorage.Layout;

    struct Layout {
        address contractOwner;
    }

    bytes32 internal constant LAYOUT_STORAGE_SLOT = bytes32(uint256(keccak256("animoca.core.access.ContractOwnership.storage")) - 1);
    bytes32 internal constant PROXY_INIT_PHASE_SLOT = bytes32(uint256(keccak256("animoca.core.access.ContractOwnership.phase")) - 1);

    /// @notice Initializes the storage with an initial contract owner (immutable version).
    /// @notice Marks the following ERC165 interface(s) as supported: ERC173.
    /// @dev Note: This function should be called ONLY in the constructor of an immutable (non-proxied) contract.
    /// @dev Emits an {OwnershipTransferred} if `initialOwner` is not the zero address.
    /// @param initialOwner The initial contract owner.
    function constructorInit(Layout storage s, address initialOwner) internal {
        if (initialOwner != address(0)) {
            s.contractOwner = initialOwner;
            emit OwnershipTransferred(address(0), initialOwner);
        }
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC173).interfaceId, true);
    }

    /// @notice Initializes the storage with an initial contract owner (proxied version).
    /// @notice Sets the proxy initialization phase to `1`.
    /// @notice Marks the following ERC165 interface(s) as supported: ERC173.
    /// @dev Note: This function should be called ONLY in the init function of a proxied contract.
    /// @dev Reverts with {InitializationPhaseAlreadyReached} if the proxy initialization phase is set to `1` or above.
    /// @dev Emits an {OwnershipTransferred} if `initialOwner` is not the zero address.
    /// @param initialOwner The initial contract owner.
    function proxyInit(Layout storage s, address initialOwner) internal {
        ProxyInitialization.setPhase(PROXY_INIT_PHASE_SLOT, 1);
        s.constructorInit(initialOwner);
    }

    /// @notice Sets the address of the new contract owner.
    /// @dev Reverts with {NotContractOwner} if `sender` is not the contract owner.
    /// @dev Emits an {OwnershipTransferred} event if `newOwner` is different from the current contract owner.
    /// @param newOwner The address of the new contract owner. Using the zero address means renouncing ownership.
    function transferOwnership(Layout storage s, address sender, address newOwner) internal {
        address previousOwner = s.contractOwner;
        if (sender != previousOwner) revert NotContractOwner(sender);
        if (previousOwner != newOwner) {
            s.contractOwner = newOwner;
            emit OwnershipTransferred(previousOwner, newOwner);
        }
    }

    /// @notice Gets the address of the contract owner.
    /// @return contractOwner The address of the contract owner.
    function owner(Layout storage s) internal view returns (address contractOwner) {
        return s.contractOwner;
    }

    /// @notice Checks whether an account is the owner of a target contract.
    /// @param targetContract The contract to check.
    /// @param account The account to check.
    /// @return isTargetContractOwner_ Whether `account` is the owner of `targetContract`.
    function isTargetContractOwner(address targetContract, address account) internal view returns (bool isTargetContractOwner_) {
        if (!targetContract.isContract()) revert TargetIsNotAContract(targetContract);
        return IERC173(targetContract).owner() == account;
    }

    /// @notice Ensures that an account is the contract owner.
    /// @dev Reverts with {NotContractOwner} if `account` is not the contract owner.
    /// @param account The account.
    function enforceIsContractOwner(Layout storage s, address account) internal view {
        if (account != s.contractOwner) revert NotContractOwner(account);
    }

    /// @notice Enforces that an account is the owner of a target contract.
    /// @dev Reverts with {NotTheTargetContractOwner} if the account is not the owner.
    /// @param targetContract The contract to check.
    /// @param account The account to check.
    function enforceIsTargetContractOwner(address targetContract, address account) internal view {
        if (!isTargetContractOwner(targetContract, account)) revert NotTargetContractOwner(targetContract, account);
    }

    function layout() internal pure returns (Layout storage s) {
        bytes32 position = LAYOUT_STORAGE_SLOT;
        assembly {
            s.slot := position
        }
    }
}


// File @openzeppelin/contracts/utils/Context.sol@v4.9.6

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.4) (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}


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


// File contracts/lib/curve/base/LinearCurveBase.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;





/// @title Linear Curve contract for calculating the price of a token.
/// @dev The curve is defined by the price function `calculatePrice` in {ICurve} interface.
/// @dev This contract is to be used via inheritance in a proxied implementation.
/// @dev Note: This contract requires ERC165 (Interface Detection Standard).
abstract contract LinearCurveBase is ICurve, ILinearCurve, Context {
    using LinearCurveStorage for LinearCurveStorage.Layout;
    using ContractOwnershipStorage for ContractOwnershipStorage.Layout;

    /// @inheritdoc ILinearCurve
    function setInitialPrice(uint256 price) external {
        address operator = _msgSender();
        ContractOwnershipStorage.layout().enforceIsContractOwner(operator);
        LinearCurveStorage.layout().setInitialPrice(price, operator);
    }

    /// @inheritdoc ILinearCurve
    function setSlopeNumerator(uint256 numerator) external {
        address operator = _msgSender();
        ContractOwnershipStorage.layout().enforceIsContractOwner(operator);
        LinearCurveStorage.layout().setSlopeNumerator(numerator, operator);
    }

    /// @inheritdoc ILinearCurve
    function setSlopeDenominator(uint256 denominator) external {
        address operator = _msgSender();
        ContractOwnershipStorage.layout().enforceIsContractOwner(operator);
        LinearCurveStorage.layout().setSlopeDenominator(denominator, operator);
    }

    /// @inheritdoc ICurve
    function calculatePrice(uint256 totalSupply, uint256 amount) external view returns (uint256 price) {
        return LinearCurveStorage.layout().calculatePrice(totalSupply, amount);
    }

    /// @inheritdoc ILinearCurve
    function initialPrice() external view returns (uint256 price) {
        return LinearCurveStorage.layout().initialPrice();
    }

    /// @inheritdoc ILinearCurve
    function slopeNumerator() external view returns (uint256 numerator) {
        return LinearCurveStorage.layout().slopeNumerator();
    }

    /// @inheritdoc ILinearCurve
    function slopeDenominator() external view returns (uint256 denominator) {
        return LinearCurveStorage.layout().slopeDenominator();
    }
}