// Sources flattened with hardhat v2.22.5 https://hardhat.org

// SPDX-License-Identifier: MIT

// File @animoca/ethereum-contracts/contracts/access/interfaces/IAccessControl.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @title Access control via roles management (functions)
interface IAccessControl {
    /// @notice Renounces a role by the sender.
    /// @dev Reverts if `sender` does not have `role`.
    /// @dev Emits a {RoleRevoked} event.
    /// @param role The role to renounce.
    function renounceRole(bytes32 role) external;

    /// @notice Retrieves whether an account has a role.
    /// @param role The role.
    /// @param account The account.
    /// @return hasRole_ Whether `account` has `role`.
    function hasRole(bytes32 role, address account) external view returns (bool hasRole_);
}


// File @animoca/ethereum-contracts/contracts/access/errors/AccessControlErrors.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Thrown when an account does not have the required role.
/// @param role The role the caller is missing.
/// @param account The account that was checked.
error NotRoleHolder(bytes32 role, address account);

/// @notice Thrown when an account does not have the required role on a target contract.
/// @param targetContract The contract that was checked.
/// @param role The role that was checked.
/// @param account The account that was checked.
error NotTargetContractRoleHolder(address targetContract, bytes32 role, address account);


// File @animoca/ethereum-contracts/contracts/access/errors/Common.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Thrown when the target contract is actually not a contract.
/// @param targetContract The contract that was checked
error TargetIsNotAContract(address targetContract);


// File @animoca/ethereum-contracts/contracts/access/events/AccessControlEvents.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Emitted when `role` is granted to `account`.
/// @param role The role that has been granted.
/// @param account The account that has been granted the role.
/// @param operator The account that granted the role.
event RoleGranted(bytes32 role, address account, address operator);

/// @notice Emitted when `role` is revoked from `account`.
/// @param role The role that has been revoked.
/// @param account The account that has been revoked the role.
/// @param operator The account that revoked the role.
event RoleRevoked(bytes32 role, address account, address operator);


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


// File @animoca/ethereum-contracts/contracts/access/libraries/AccessControlStorage.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;





library AccessControlStorage {
    using Address for address;
    using AccessControlStorage for AccessControlStorage.Layout;

    struct Layout {
        mapping(bytes32 => mapping(address => bool)) roles;
    }

    bytes32 internal constant LAYOUT_STORAGE_SLOT = bytes32(uint256(keccak256("animoca.core.access.AccessControl.storage")) - 1);

    /// @notice Grants a role to an account.
    /// @dev Note: Call to this function should be properly access controlled.
    /// @dev Emits a {RoleGranted} event if the account did not previously have the role.
    /// @param role The role to grant.
    /// @param account The account to grant the role to.
    /// @param operator The account requesting the role change.
    function grantRole(Layout storage s, bytes32 role, address account, address operator) internal {
        if (!s.hasRole(role, account)) {
            s.roles[role][account] = true;
            emit RoleGranted(role, account, operator);
        }
    }

    /// @notice Revokes a role from an account.
    /// @dev Note: Call to this function should be properly access controlled.
    /// @dev Emits a {RoleRevoked} event if the account previously had the role.
    /// @param role The role to revoke.
    /// @param account The account to revoke the role from.
    /// @param operator The account requesting the role change.
    function revokeRole(Layout storage s, bytes32 role, address account, address operator) internal {
        if (s.hasRole(role, account)) {
            s.roles[role][account] = false;
            emit RoleRevoked(role, account, operator);
        }
    }

    /// @notice Renounces a role by the sender.
    /// @dev Reverts with {NotRoleHolder} if `sender` does not have `role`.
    /// @dev Emits a {RoleRevoked} event.
    /// @param sender The message sender.
    /// @param role The role to renounce.
    function renounceRole(Layout storage s, address sender, bytes32 role) internal {
        s.enforceHasRole(role, sender);
        s.roles[role][sender] = false;
        emit RoleRevoked(role, sender, sender);
    }

    /// @notice Retrieves whether an account has a role.
    /// @param role The role.
    /// @param account The account.
    /// @return hasRole_ Whether `account` has `role`.
    function hasRole(Layout storage s, bytes32 role, address account) internal view returns (bool hasRole_) {
        return s.roles[role][account];
    }

    /// @notice Checks whether an account has a role in a target contract.
    /// @param targetContract The contract to check.
    /// @param role The role to check.
    /// @param account The account to check.
    /// @return hasTargetContractRole_ Whether `account` has `role` in `targetContract`.
    function hasTargetContractRole(address targetContract, bytes32 role, address account) internal view returns (bool hasTargetContractRole_) {
        if (!targetContract.isContract()) revert TargetIsNotAContract(targetContract);
        return IAccessControl(targetContract).hasRole(role, account);
    }

    /// @notice Ensures that an account has a role.
    /// @dev Reverts with {NotRoleHolder} if `account` does not have `role`.
    /// @param role The role.
    /// @param account The account.
    function enforceHasRole(Layout storage s, bytes32 role, address account) internal view {
        if (!s.hasRole(role, account)) revert NotRoleHolder(role, account);
    }

    /// @notice Enforces that an account has a role in a target contract.
    /// @dev Reverts with {NotTargetContractRoleHolder} if the account does not have the role.
    /// @param targetContract The contract to check.
    /// @param role The role to check.
    /// @param account The account to check.
    function enforceHasTargetContractRole(address targetContract, bytes32 role, address account) internal view {
        if (!hasTargetContractRole(targetContract, role, account)) revert NotTargetContractRoleHolder(targetContract, role, account);
    }

    function layout() internal pure returns (Layout storage s) {
        bytes32 position = LAYOUT_STORAGE_SLOT;
        assembly {
            s.slot := position
        }
    }
}


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


// File @animoca/ethereum-contracts/contracts/access/base/AccessControlBase.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;




/// @title Access control via roles management (proxiable version).
/// @dev This contract is to be used via inheritance in a proxied implementation.
/// @dev Note: This contract requires ERC173 (Contract Ownership standard).
abstract contract AccessControlBase is IAccessControl, Context {
    using AccessControlStorage for AccessControlStorage.Layout;
    using ContractOwnershipStorage for ContractOwnershipStorage.Layout;

    /// @notice Grants a role to an account.
    /// @dev Reverts with {NotContractOwner} if the sender is not the contract owner.
    /// @dev Emits a {RoleGranted} event if the account did not previously have the role.
    /// @param role The role to grant.
    /// @param account The account to grant the role to.
    function grantRole(bytes32 role, address account) external {
        address operator = _msgSender();
        ContractOwnershipStorage.layout().enforceIsContractOwner(operator);
        AccessControlStorage.layout().grantRole(role, account, operator);
    }

    /// @notice Revokes a role from an account.
    /// @dev Reverts with {NotContractOwner} if the sender is not the contract owner.
    /// @dev Emits a {RoleRevoked} event if the account previously had the role.
    /// @param role The role to revoke.
    /// @param account The account to revoke the role from.
    function revokeRole(bytes32 role, address account) external {
        address operator = _msgSender();
        ContractOwnershipStorage.layout().enforceIsContractOwner(operator);
        AccessControlStorage.layout().revokeRole(role, account, operator);
    }

    /// @inheritdoc IAccessControl
    function renounceRole(bytes32 role) external {
        AccessControlStorage.layout().renounceRole(_msgSender(), role);
    }

    /// @inheritdoc IAccessControl
    function hasRole(bytes32 role, address account) external view returns (bool hasRole_) {
        return AccessControlStorage.layout().hasRole(role, account);
    }
}


// File @animoca/ethereum-contracts/contracts/access/base/ContractOwnershipBase.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;



/// @title ERC173 Contract Ownership Standard (proxiable version).
/// @dev See https://eips.ethereum.org/EIPS/eip-173
/// @dev This contract is to be used via inheritance in a proxied implementation.
/// @dev Note: This contract requires ERC165 (Interface Detection Standard).
abstract contract ContractOwnershipBase is IERC173, Context {
    using ContractOwnershipStorage for ContractOwnershipStorage.Layout;

    /// @inheritdoc IERC173
    function owner() public view virtual returns (address) {
        return ContractOwnershipStorage.layout().owner();
    }

    /// @inheritdoc IERC173
    function transferOwnership(address newOwner) public virtual {
        ContractOwnershipStorage.layout().transferOwnership(_msgSender(), newOwner);
    }
}


// File @animoca/ethereum-contracts/contracts/introspection/InterfaceDetection.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;


/// @title ERC165 Interface Detection Standard (immutable or proxiable version).
/// @dev This contract is to be used via inheritance in an immutable (non-proxied) or proxied implementation.
abstract contract InterfaceDetection is IERC165 {
    using InterfaceDetectionStorage for InterfaceDetectionStorage.Layout;

    /// @inheritdoc IERC165
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return InterfaceDetectionStorage.layout().supportsInterface(interfaceId);
    }
}


// File @animoca/ethereum-contracts/contracts/access/ContractOwnership.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;



/// @title ERC173 Contract Ownership Standard (immutable version).
/// @dev See https://eips.ethereum.org/EIPS/eip-173
/// @dev This contract is to be used via inheritance in an immutable (non-proxied) implementation.
abstract contract ContractOwnership is ContractOwnershipBase, InterfaceDetection {
    using ContractOwnershipStorage for ContractOwnershipStorage.Layout;

    /// @notice Initializes the storage with an initial contract owner.
    /// @notice Marks the following ERC165 interface(s) as supported: ERC173.
    /// @dev Emits an {OwnershipTransferred} if `initialOwner` is not the zero address.
    /// @param initialOwner the initial contract owner.
    constructor(address initialOwner) {
        ContractOwnershipStorage.layout().constructorInit(initialOwner);
    }
}


// File @animoca/ethereum-contracts/contracts/access/AccessControl.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;


/// @title Access control via roles management (immutable version).
/// @dev This contract is to be used via inheritance in an immutable (non-proxied) implementation.
abstract contract AccessControl is AccessControlBase, ContractOwnership {}


// File @animoca/ethereum-contracts/contracts/token/ERC721/interfaces/IERC721.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @title ERC721 Non-Fungible Token Standard, basic interface (functions).
/// @dev See https://eips.ethereum.org/EIPS/eip-721
/// @dev This interface only contains the standard functions. See IERC721Events for the events.
/// @dev Note: The ERC-165 identifier for this interface is 0x80ac58cd.
interface IERC721 {
    /// @notice Sets or unsets an approval to transfer a single token on behalf of its owner.
    /// @dev Note: There can only be one approved address per token at a given time.
    /// @dev Note: A token approval gets reset when this token is transferred, including a self-transfer.
    /// @dev Reverts if `tokenId` does not exist.
    /// @dev Reverts if `to` is the token owner.
    /// @dev Reverts if the sender is not the token owner and has not been approved by the token owner.
    /// @dev Emits an {Approval} event.
    /// @param to The address to approve, or the zero address to remove any existing approval.
    /// @param tokenId The token identifier to give approval for.
    function approve(address to, uint256 tokenId) external;

    /// @notice Sets or unsets an approval to transfer all tokens on behalf of their owner.
    /// @dev Reverts if the sender is the same as `operator`.
    /// @dev Emits an {ApprovalForAll} event.
    /// @param operator The address to approve for all tokens.
    /// @param approved True to set an approval for all tokens, false to unset it.
    function setApprovalForAll(address operator, bool approved) external;

    /// @notice Unsafely transfers the ownership of a token to a recipient.
    /// @dev Note: Usage of this method is discouraged, use `safeTransferFrom` whenever possible.
    /// @dev Resets the token approval for `tokenId`.
    /// @dev Reverts if `to` is the zero address.
    /// @dev Reverts if `from` is not the owner of `tokenId`.
    /// @dev Reverts if the sender is not `from` and has not been approved by `from` for `tokenId`.
    /// @dev Emits a {Transfer} event.
    /// @param from The current token owner.
    /// @param to The recipient of the token transfer. Self-transfers are possible.
    /// @param tokenId The identifier of the token to transfer.
    function transferFrom(address from, address to, uint256 tokenId) external;

    /// @notice Safely transfers the ownership of a token to a recipient.
    /// @dev Resets the token approval for `tokenId`.
    /// @dev Reverts if `to` is the zero address.
    /// @dev Reverts if `from` is not the owner of `tokenId`.
    /// @dev Reverts if the sender is not `from` and has not been approved by `from` for `tokenId`.
    /// @dev Reverts if `to` is a contract and the call to {IERC721Receiver-onERC721Received} fails, reverts or is rejected.
    /// @dev Emits a {Transfer} event.
    /// @param from The current token owner.
    /// @param to The recipient of the token transfer.
    /// @param tokenId The identifier of the token to transfer.
    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    /// @notice Safely transfers the ownership of a token to a recipient.
    /// @dev Resets the token approval for `tokenId`.
    /// @dev Reverts if `to` is the zero address.
    /// @dev Reverts if `from` is not the owner of `tokenId`.
    /// @dev Reverts if the sender is not `from` and has not been approved by `from` for `tokenId`.
    /// @dev Reverts if `to` is a contract and the call to {IERC721Receiver-onERC721Received} fails, reverts or is rejected.
    /// @dev Emits a {Transfer} event.
    /// @param from The current token owner.
    /// @param to The recipient of the token transfer.
    /// @param tokenId The identifier of the token to transfer.
    /// @param data Optional data to send along to a receiver contract.
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;

    /// @notice Gets the balance of an address.
    /// @dev Reverts if `owner` is the zero address.
    /// @param owner The address to query the balance of.
    /// @return balance The amount owned by the owner.
    function balanceOf(address owner) external view returns (uint256 balance);

    /// @notice Gets the owner of a token.
    /// @dev Reverts if `tokenId` does not exist.
    /// @param tokenId The token identifier to query the owner of.
    /// @return tokenOwner The owner of the token identifier.
    function ownerOf(uint256 tokenId) external view returns (address tokenOwner);

    /// @notice Gets the approved address for a token.
    /// @dev Reverts if `tokenId` does not exist.
    /// @param tokenId The token identifier to query the approval of.
    /// @return approved The approved address for the token identifier, or the zero address if no approval is set.
    function getApproved(uint256 tokenId) external view returns (address approved);

    /// @notice Gets whether an operator is approved for all tokens by an owner.
    /// @param owner The address which gives the approval for all tokens.
    /// @param operator The address which receives the approval for all tokens.
    /// @return approvedForAll Whether the operator is approved for all tokens by the owner.
    function isApprovedForAll(address owner, address operator) external view returns (bool approvedForAll);
}


// File @animoca/ethereum-contracts/contracts/CommonErrors.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Thrown when trying to transfer tokens without calldata to the contract.
error EtherReceptionDisabled();

/// @notice Thrown when the multiple related arrays have different lengths.
error InconsistentArrayLengths();

/// @notice Thrown when an ETH transfer has failed.
error TransferFailed();


// File @animoca/ethereum-contracts/contracts/token/ERC721/errors/ERC721Errors.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Thrown when trying to approve oneself.
/// @param account The account trying to approve itself.
error ERC721SelfApproval(address account);

/// @notice Thrown when trying to approveForAll oneself.
/// @param account The account trying to approveForAll itself.
error ERC721SelfApprovalForAll(address account);

/// @notice Thrown when a sender tries to set a token approval but is neither the owner nor approvedForAll by the owner.
/// @param sender The message sender.
/// @param tokenId The identifier of the token.
error ERC721NonApprovedForApproval(address sender, address owner, uint256 tokenId);

/// @notice Thrown when transferring a token to the zero address.
error ERC721TransferToAddressZero();

/// @notice Thrown when a token does not exist but is required to.
/// @param tokenId The identifier of the token that was checked.
error ERC721NonExistingToken(uint256 tokenId);

/// @notice Thrown when a sender tries to transfer a token but is neither the owner nor approved by the owner.
/// @param sender The message sender.
/// @param tokenId The identifier of the token.
error ERC721NonApprovedForTransfer(address sender, address owner, uint256 tokenId);

/// @notice Thrown when a token is not owned by the expected account.
/// @param account The account that was expected to own the token.
/// @param tokenId The identifier of the token.
error ERC721NonOwnedToken(address account, uint256 tokenId);

/// @notice Thrown when a safe transfer is rejected by the recipient contract.
/// @param recipient The recipient contract.
/// @param tokenId The identifier of the token.
error ERC721SafeTransferRejected(address recipient, uint256 tokenId);

/// @notice Thrown when querying the balance of the zero address.
error ERC721BalanceOfAddressZero();


// File @animoca/ethereum-contracts/contracts/token/ERC721/errors/ERC721MintableErrors.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Thrown when minting a token to the zero address.
error ERC721MintToAddressZero();

/// @notice Thrown when minting a token that already exists.
/// @param tokenId The identifier of the token that already exists.
error ERC721ExistingToken(uint256 tokenId);


// File @animoca/ethereum-contracts/contracts/token/ERC721/errors/ERC721MintableOnceErrors.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Thrown when minting a token which has been burnt before (MintableOnce implementation).
/// @param tokenId The identifier of the token that has been burnt before.
error ERC721BurntToken(uint256 tokenId);


// File @animoca/ethereum-contracts/contracts/token/ERC721/events/ERC721Events.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Emitted when a token is transferred.
/// @param from The previous token owner.
/// @param to The new token owner.
/// @param tokenId The transferred token identifier.
event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

/// @notice Emitted when a single token approval is set.
/// @param owner The token owner.
/// @param approved The approved address.
/// @param tokenId The approved token identifier.
event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

/// @notice Emitted when an approval for all tokens is set or unset.
/// @param owner The tokens owner.
/// @param operator The approved address.
/// @param approved True when then approval is set, false when it is unset.
event ApprovalForAll(address indexed owner, address indexed operator, bool approved);


// File @animoca/ethereum-contracts/contracts/token/ERC721/interfaces/IERC721BatchTransfer.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @title ERC721 Non-Fungible Token Standard, optional extension: Batch Transfer.
/// @dev See https://eips.ethereum.org/EIPS/eip-721
/// @dev Note: The ERC-165 identifier for this interface is 0xf3993d11.
interface IERC721BatchTransfer {
    /// @notice Unsafely transfers a batch of tokens to a recipient.
    /// @dev Resets the token approval for each of `tokenIds`.
    /// @dev Reverts if `to` is the zero address.
    /// @dev Reverts if one of `tokenIds` is not owned by `from`.
    /// @dev Reverts if the sender is not `from` and has not been approved by `from` for each of `tokenIds`.
    /// @dev Emits an {IERC721-Transfer} event for each of `tokenIds`.
    /// @param from Current tokens owner.
    /// @param to Address of the new token owner.
    /// @param tokenIds Identifiers of the tokens to transfer.
    function batchTransferFrom(address from, address to, uint256[] calldata tokenIds) external;
}


// File @animoca/ethereum-contracts/contracts/token/ERC721/interfaces/IERC721Burnable.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @title ERC721 Non-Fungible Token Standard, optional extension: Burnable.
/// @dev See https://eips.ethereum.org/EIPS/eip-721
/// @dev Note: The ERC-165 identifier for this interface is 0x8b8b4ef5.
interface IERC721Burnable {
    /// @notice Burns a token.
    /// @dev Reverts if `tokenId` is not owned by `from`.
    /// @dev Reverts if the sender is not `from` and has not been approved by `from` for `tokenId`.
    /// @dev Emits an {IERC721-Transfer} event with `to` set to the zero address.
    /// @param from The current token owner.
    /// @param tokenId The identifier of the token to burn.
    function burnFrom(address from, uint256 tokenId) external;

    /// @notice Burns a batch of tokens.
    /// @dev Reverts if one of `tokenIds` is not owned by `from`.
    /// @dev Reverts if the sender is not `from` and has not been approved by `from` for each of `tokenIds`.
    /// @dev Emits an {IERC721-Transfer} event with `to` set to the zero address for each of `tokenIds`.
    /// @param from The current tokens owner.
    /// @param tokenIds The identifiers of the tokens to burn.
    function batchBurnFrom(address from, uint256[] calldata tokenIds) external;
}


// File @animoca/ethereum-contracts/contracts/token/ERC721/interfaces/IERC721Deliverable.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @title ERC721 Non-Fungible Token Standard, optional extension: Deliverable.
/// @dev See https://eips.ethereum.org/EIPS/eip-721
/// @dev Note: The ERC-165 identifier for this interface is 0x9da5e832.
interface IERC721Deliverable {
    /// @notice Unsafely mints tokens to multiple recipients.
    /// @dev Reverts if `recipients` and `tokenIds` have different lengths.
    /// @dev Reverts if one of `recipients` is the zero address.
    /// @dev Reverts if one of `tokenIds` already exists.
    /// @dev Emits an {IERC721-Transfer} event from the zero address for each of `recipients` and `tokenIds`.
    /// @param recipients Addresses of the new tokens owners.
    /// @param tokenIds Identifiers of the tokens to mint.
    function deliver(address[] calldata recipients, uint256[] calldata tokenIds) external;
}


// File @animoca/ethereum-contracts/contracts/token/ERC721/interfaces/IERC721Metadata.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @title ERC721 Non-Fungible Token Standard, optional extension: Metadata.
/// @dev See https://eips.ethereum.org/EIPS/eip-721
/// @dev Note: The ERC-165 identifier for this interface is 0x5b5e139f.
interface IERC721Metadata {
    /// @notice Gets the name of the token. E.g. "My Token".
    /// @return tokenName The name of the token.
    function name() external view returns (string memory tokenName);

    /// @notice Gets the symbol of the token. E.g. "TOK".
    /// @return tokenSymbol The symbol of the token.
    function symbol() external view returns (string memory tokenSymbol);

    /// @notice Gets the metadata URI for a token identifier.
    /// @dev Reverts if `tokenId` does not exist.
    /// @param tokenId The token identifier.
    /// @return uri The metadata URI for the token identifier.
    function tokenURI(uint256 tokenId) external view returns (string memory uri);
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


// File @animoca/ethereum-contracts/contracts/token/ERC721/interfaces/IERC721Receiver.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @title ERC721 Non-Fungible Token Standard, Tokens Receiver.
/// @notice Interface for supporting safe transfers from ERC721 contracts.
/// @dev See https://eips.ethereum.org/EIPS/eip-721
/// @dev Note: The ERC-165 identifier for this interface is 0x150b7a02.
interface IERC721Receiver {
    /// @notice Handles the receipt of an ERC721 token.
    /// @dev Note: This function is called by an ERC721 contract after a safe transfer.
    /// @dev Note: The ERC721 contract address is always the message sender.
    /// @param operator The initiator of the safe transfer.
    /// @param from The previous token owner.
    /// @param tokenId The token identifier.
    /// @param data Optional additional data with no specified format.
    /// @return magicValue `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))` (`0x150b7a02`) to accept, any other value to refuse.
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4 magicValue);
}


// File @animoca/ethereum-contracts/contracts/token/ERC721/libraries/ERC721Storage.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

// solhint-disable-next-line max-line-length














library ERC721Storage {
    using Address for address;
    using ERC721Storage for ERC721Storage.Layout;
    using InterfaceDetectionStorage for InterfaceDetectionStorage.Layout;

    struct Layout {
        mapping(uint256 => uint256) owners;
        mapping(address => uint256) balances;
        mapping(uint256 => address) approvals;
        mapping(address => mapping(address => bool)) operators;
    }

    bytes32 internal constant LAYOUT_STORAGE_SLOT = bytes32(uint256(keccak256("animoca.token.ERC721.ERC721.storage")) - 1);

    bytes4 internal constant ERC721_RECEIVED = IERC721Receiver.onERC721Received.selector;

    // Single token approval flag
    // This bit is set in the owner's value to indicate that there is an approval set for this token
    uint256 internal constant TOKEN_APPROVAL_OWNER_FLAG = 1 << 160;

    // Burnt token magic value
    // This magic number is used as the owner's value to indicate that the token has been burnt
    uint256 internal constant BURNT_TOKEN_OWNER_VALUE = 0xdead000000000000000000000000000000000000000000000000000000000000;

    /// @notice Marks the following ERC165 interface(s) as supported: ERC721.
    function init() internal {
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC721).interfaceId, true);
    }

    /// @notice Marks the following ERC165 interface(s) as supported: ERC721BatchTransfer.
    function initERC721BatchTransfer() internal {
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC721BatchTransfer).interfaceId, true);
    }

    /// @notice Marks the following ERC165 interface(s) as supported: ERC721Metadata.
    function initERC721Metadata() internal {
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC721Metadata).interfaceId, true);
    }

    /// @notice Marks the following ERC165 interface(s) as supported: ERC721Mintable.
    function initERC721Mintable() internal {
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC721Mintable).interfaceId, true);
    }

    /// @notice Marks the following ERC165 interface(s) as supported: ERC721Deliverable.
    function initERC721Deliverable() internal {
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC721Deliverable).interfaceId, true);
    }

    /// @notice Marks the following ERC165 interface(s) as supported: ERC721Burnable.
    function initERC721Burnable() internal {
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC721Burnable).interfaceId, true);
    }

    /// @notice Sets or unsets an approval to transfer a single token on behalf of its owner.
    /// @dev Note: This function implements {ERC721-approve(address,uint256)}.
    /// @dev Reverts with {ERC721NonExistingToken} if `tokenId` does not exist.
    /// @dev Reverts with {ERC721SelfApproval} if `to` is the token owner.
    /// @dev Reverts with {ERC721NonApprovedForApproval} if `sender` is not the token owner and has not been approved by the token owner.
    /// @dev Emits an {Approval} event.
    /// @param sender The message sender.
    /// @param to The address to approve, or the zero address to remove any existing approval.
    /// @param tokenId The token identifier to give approval for.
    function approve(Layout storage s, address sender, address to, uint256 tokenId) internal {
        uint256 owner = s.owners[tokenId];
        if (!_tokenExists(owner)) revert ERC721NonExistingToken(tokenId);
        address ownerAddress = _tokenOwner(owner);
        if (to == ownerAddress) revert ERC721SelfApproval(ownerAddress);
        if (!_isOperatable(s, ownerAddress, sender)) revert ERC721NonApprovedForApproval(sender, ownerAddress, tokenId);
        if (to == address(0)) {
            if (_tokenHasApproval(owner)) {
                // remove the approval bit if it is present
                s.owners[tokenId] = uint256(uint160(ownerAddress));
            }
        } else {
            uint256 ownerWithApprovalBit = owner | TOKEN_APPROVAL_OWNER_FLAG;
            if (owner != ownerWithApprovalBit) {
                // add the approval bit if it is not present
                s.owners[tokenId] = ownerWithApprovalBit;
            }
            s.approvals[tokenId] = to;
        }
        emit Approval(ownerAddress, to, tokenId);
    }

    /// @notice Sets or unsets an approval to transfer all tokens on behalf of their owner.
    /// @dev Note: This function implements {ERC721-setApprovalForAll(address,bool)}.
    /// @dev Reverts with {ERC721SelfApprovalForAll} if `sender` is the same as `operator`.
    /// @dev Emits an {ApprovalForAll} event.
    /// @param sender The message sender.
    /// @param operator The address to approve for all tokens.
    /// @param approved True to set an approval for all tokens, false to unset it.
    function setApprovalForAll(Layout storage s, address sender, address operator, bool approved) internal {
        if (operator == sender) revert ERC721SelfApprovalForAll(sender);
        s.operators[sender][operator] = approved;
        emit ApprovalForAll(sender, operator, approved);
    }

    /// @notice Unsafely transfers the ownership of a token to a recipient by a sender.
    /// @dev Note: This function implements {ERC721-transferFrom(address,address,uint256)}.
    /// @dev Resets the token approval for `tokenId`.
    /// @dev Reverts with {ERC721TransferToAddressZero} if `to` is the zero address.
    /// @dev Reverts with {ERC721NonExistingToken} if `tokenId` does not exist.
    /// @dev Reverts with {ERC721NonOwnedToken} if `from` is not the owner of `tokenId`.
    /// @dev Reverts with {ERC721NonApprovedForTransfer} if `sender` is not `from` and has not been approved by `from` for `tokenId`.
    /// @dev Emits a {Transfer} event.
    /// @param sender The message sender.
    /// @param from The current token owner.
    /// @param to The recipient of the token transfer.
    /// @param tokenId The identifier of the token to transfer.
    function transferFrom(Layout storage s, address sender, address from, address to, uint256 tokenId) internal {
        if (to == address(0)) revert ERC721TransferToAddressZero();

        uint256 owner = s.owners[tokenId];
        if (!_tokenExists(owner)) revert ERC721NonExistingToken(tokenId);
        if (_tokenOwner(owner) != from) revert ERC721NonOwnedToken(from, tokenId);

        if (!_isOperatable(s, from, sender)) {
            if (!_tokenHasApproval(owner) || sender != s.approvals[tokenId]) revert ERC721NonApprovedForTransfer(sender, from, tokenId);
        }

        s.owners[tokenId] = uint256(uint160(to));
        if (from != to) {
            unchecked {
                // cannot underflow as balance is verified through ownership
                --s.balances[from];
                //  cannot overflow as supply cannot overflow
                ++s.balances[to];
            }
        }

        emit Transfer(from, to, tokenId);
    }

    /// @notice Safely transfers the ownership of a token to a recipient by a sender.
    /// @dev Note: This function implements {ERC721-safeTransferFrom(address,address,uint256)}.
    /// @dev Warning: Since a `to` contract can run arbitrary code, developers should be aware of potential re-entrancy attacks.
    /// @dev Resets the token approval for `tokenId`.
    /// @dev Reverts with {ERC721TransferToAddressZero} if `to` is the zero address.
    /// @dev Reverts with {ERC721NonExistingToken} if `tokenId` does not exist.
    /// @dev Reverts with {ERC721NonOwnedToken} if `from` is not the owner of `tokenId`.
    /// @dev Reverts with {ERC721NonApprovedForTransfer} if `sender` is not `from` and has not been approved by `from` for `tokenId`.
    /// @dev Reverts with {ERC721SafeTransferRejected} if `to` is a contract and the call to
    ///  {IERC721Receiver-onERC721Received} fails, reverts or is rejected.
    /// @dev Emits a {Transfer} event.
    /// @param sender The message sender.
    /// @param from The current token owner.
    /// @param to The recipient of the token transfer.
    /// @param tokenId The identifier of the token to transfer.
    function safeTransferFrom(Layout storage s, address sender, address from, address to, uint256 tokenId) internal {
        s.transferFrom(sender, from, to, tokenId);
        if (to.isContract()) {
            _callOnERC721Received(sender, from, to, tokenId, "");
        }
    }

    /// @notice Safely transfers the ownership of a token to a recipient by a sender.
    /// @dev Note: This function implements {ERC721-safeTransferFrom(address,address,uint256,bytes)}.
    /// @dev Warning: Since a `to` contract can run arbitrary code, developers should be aware of potential re-entrancy attacks.
    /// @dev Resets the token approval for `tokenId`.
    /// @dev Reverts with {ERC721TransferToAddressZero} if `to` is the zero address.
    /// @dev Reverts with {ERC721NonExistingToken} if `tokenId` does not exist.
    /// @dev Reverts with {ERC721NonOwnedToken} if `from` is not the owner of `tokenId`.
    /// @dev Reverts with {ERC721NonApprovedForTransfer} if `sender` is not `from` and has not been approved by `from` for `tokenId`.
    /// @dev Reverts with {ERC721SafeTransferRejected} if `to` is a contract and the call to
    ///  {IERC721Receiver-onERC721Received} fails, reverts or is rejected.
    /// @dev Emits a {Transfer} event.
    /// @param sender The message sender.
    /// @param from The current token owner.
    /// @param to The recipient of the token transfer.
    /// @param tokenId The identifier of the token to transfer.
    /// @param data Optional data to send along to a receiver contract.
    function safeTransferFrom(Layout storage s, address sender, address from, address to, uint256 tokenId, bytes calldata data) internal {
        s.transferFrom(sender, from, to, tokenId);
        if (to.isContract()) {
            _callOnERC721Received(sender, from, to, tokenId, data);
        }
    }

    /// @notice Unsafely transfers a batch of tokens to a recipient by a sender.
    /// @dev Note: This function implements {ERC721BatchTransfer-batchTransferFrom(address,address,uint256[])}.
    /// @dev Resets the token approval for each of `tokenIds`.
    /// @dev Reverts with {ERC721TransferToAddressZero} if `to` is the zero address.
    /// @dev Reverts with {ERC721NonExistingToken} if one of `tokenIds` does not exist.
    /// @dev Reverts with {ERC721NonOwnedToken} if one of `tokenIds` is not owned by `from`.
    /// @dev Reverts with {ERC721NonApprovedForTransfer} if the sender is not `from` and has not been approved by `from` for each of `tokenIds`.
    /// @dev Emits a {Transfer} event for each of `tokenIds`.
    /// @param sender The message sender.
    /// @param from Current tokens owner.
    /// @param to Address of the new token owner.
    /// @param tokenIds Identifiers of the tokens to transfer.
    function batchTransferFrom(Layout storage s, address sender, address from, address to, uint256[] calldata tokenIds) internal {
        if (to == address(0)) revert ERC721TransferToAddressZero();
        bool operatable = _isOperatable(s, from, sender);

        uint256 length = tokenIds.length;
        for (uint256 i; i < length; ++i) {
            uint256 tokenId = tokenIds[i];
            uint256 owner = s.owners[tokenId];
            if (!_tokenExists(owner)) revert ERC721NonExistingToken(tokenId);
            if (_tokenOwner(owner) != from) revert ERC721NonOwnedToken(from, tokenId);
            if (!operatable) {
                if (!_tokenHasApproval(owner) || sender != s.approvals[tokenId]) revert ERC721NonApprovedForTransfer(sender, from, tokenId);
            }
            s.owners[tokenId] = uint256(uint160(to));
            emit Transfer(from, to, tokenId);
        }

        if (from != to && length != 0) {
            unchecked {
                // cannot underflow as balance is verified through ownership
                s.balances[from] -= length;
                // cannot overflow as supply cannot overflow
                s.balances[to] += length;
            }
        }
    }

    /// @notice Unsafely mints a token.
    /// @dev Note: This function implements {ERC721Mintable-mint(address,uint256)}.
    /// @dev Note: Either `mint` or `mintOnce` should be used in a given contract, but not both.
    /// @dev Reverts with {ERC721MintToAddressZero} if `to` is the zero address.
    /// @dev Reverts with {ERC721ExistingToken} if `tokenId` already exists.
    /// @dev Emits a {Transfer} event from the zero address.
    /// @param to Address of the new token owner.
    /// @param tokenId Identifier of the token to mint.
    function mint(Layout storage s, address to, uint256 tokenId) internal {
        if (to == address(0)) revert ERC721MintToAddressZero();
        if (_tokenExists(s.owners[tokenId])) revert ERC721ExistingToken(tokenId);

        s.owners[tokenId] = uint256(uint160(to));

        unchecked {
            // cannot overflow due to the cost of minting individual tokens
            ++s.balances[to];
        }

        emit Transfer(address(0), to, tokenId);
    }

    /// @notice Safely mints a token.
    /// @dev Note: This function implements {ERC721Mintable-safeMint(address,uint256,bytes)}.
    /// @dev Note: Either `safeMint` or `safeMintOnce` should be used in a given contract, but not both.
    /// @dev Warning: Since a `to` contract can run arbitrary code, developers should be aware of potential re-entrancy attacks.
    /// @dev Reverts with {ERC721MintToAddressZero} if `to` is the zero address.
    /// @dev Reverts with {ERC721ExistingToken} if `tokenId` already exists.
    /// @dev Reverts with {ERC721SafeTransferRejected} if `to` is a contract and the call to
    ///  {IERC721Receiver-onERC721Received} fails, reverts or is rejected.
    /// @dev Emits a {Transfer} event from the zero address.
    /// @param to Address of the new token owner.
    /// @param tokenId Identifier of the token to mint.
    /// @param data Optional data to pass along to the receiver call.
    function safeMint(Layout storage s, address sender, address to, uint256 tokenId, bytes memory data) internal {
        s.mint(to, tokenId);
        if (to.isContract()) {
            _callOnERC721Received(sender, address(0), to, tokenId, data);
        }
    }

    /// @notice Unsafely mints a batch of tokens.
    /// @dev Note: This function implements {ERC721Mintable-batchMint(address,uint256[])}.
    /// @dev Note: Either `batchMint` or `batchMintOnce` should be used in a given contract, but not both.
    /// @dev Reverts with {ERC721MintToAddressZero} if `to` is the zero address.
    /// @dev Reverts with {ERC721ExistingToken} if one of `tokenIds` already exists.
    /// @dev Emits a {Transfer} event from the zero address for each of `tokenIds`.
    /// @param to Address of the new tokens owner.
    /// @param tokenIds Identifiers of the tokens to mint.
    function batchMint(Layout storage s, address to, uint256[] memory tokenIds) internal {
        if (to == address(0)) revert ERC721MintToAddressZero();

        uint256 length = tokenIds.length;
        for (uint256 i; i < length; ++i) {
            uint256 tokenId = tokenIds[i];
            if (_tokenExists(s.owners[tokenId])) revert ERC721ExistingToken(tokenId);

            s.owners[tokenId] = uint256(uint160(to));
            emit Transfer(address(0), to, tokenId);
        }

        unchecked {
            s.balances[to] += length;
        }
    }

    /// @notice Unsafely mints tokens to multiple recipients.
    /// @dev Note: This function implements {ERC721Deliverable-deliver(address[],uint256[])}.
    /// @dev Note: Either `deliver` or `deliverOnce` should be used in a given contract, but not both.
    /// @dev Reverts with {InconsistentArrayLengths} if `recipients` and `tokenIds` have different lengths.
    /// @dev Reverts with {ERC721MintToAddressZero} if one of `recipients` is the zero address.
    /// @dev Reverts with {ERC721ExistingToken} if one of `tokenIds` already exists.
    /// @dev Emits a {Transfer} event from the zero address for each of `recipients` and `tokenIds`.
    /// @param recipients Addresses of the new tokens owners.
    /// @param tokenIds Identifiers of the tokens to mint.
    function deliver(Layout storage s, address[] memory recipients, uint256[] memory tokenIds) internal {
        uint256 length = recipients.length;
        if (length != tokenIds.length) revert InconsistentArrayLengths();
        for (uint256 i; i < length; ++i) {
            s.mint(recipients[i], tokenIds[i]);
        }
    }

    /// @notice Unsafely mints a token once.
    /// @dev Note: This function implements {ERC721Mintable-mint(address,uint256)}.
    /// @dev Note: Either `mint` or `mintOnce` should be used in a given contract, but not both.
    /// @dev Reverts with {ERC721MintToAddressZero} if `to` is the zero address.
    /// @dev Reverts with {ERC721ExistingToken} if `tokenId` already exists.
    /// @dev Reverts with {ERC721BurntToken} if `tokenId` has been previously burnt.
    /// @dev Emits a {Transfer} event from the zero address.
    /// @param to Address of the new token owner.
    /// @param tokenId Identifier of the token to mint.
    function mintOnce(Layout storage s, address to, uint256 tokenId) internal {
        if (to == address(0)) revert ERC721MintToAddressZero();

        uint256 owner = s.owners[tokenId];
        if (_tokenExists(owner)) revert ERC721ExistingToken(tokenId);
        if (_tokenWasBurnt(owner)) revert ERC721BurntToken(tokenId);

        s.owners[tokenId] = uint256(uint160(to));

        unchecked {
            // cannot overflow due to the cost of minting individual tokens
            ++s.balances[to];
        }

        emit Transfer(address(0), to, tokenId);
    }

    /// @notice Safely mints a token once.
    /// @dev Note: This function implements {ERC721Mintable-safeMint(address,uint256,bytes)}.
    /// @dev Note: Either `safeMint` or `safeMintOnce` should be used in a given contract, but not both.
    /// @dev Reverts with {ERC721MintToAddressZero} if `to` is the zero address.
    /// @dev Reverts with {ERC721ExistingToken} if `tokenId` already exists.
    /// @dev Reverts with {ERC721BurntToken} if `tokenId` has been previously burnt.
    /// @dev Reverts with {ERC721SafeTransferRejected} if `to` is a contract and the call to
    ///  {IERC721Receiver-onERC721Received} fails, reverts or is rejected.
    /// @dev Emits a {Transfer} event from the zero address.
    /// @param to Address of the new token owner.
    /// @param tokenId Identifier of the token to mint.
    /// @param data Optional data to pass along to the receiver call.
    function safeMintOnce(Layout storage s, address sender, address to, uint256 tokenId, bytes memory data) internal {
        s.mintOnce(to, tokenId);
        if (to.isContract()) {
            _callOnERC721Received(sender, address(0), to, tokenId, data);
        }
    }

    /// @notice Unsafely mints a batch of tokens once.
    /// @dev Note: This function implements {ERC721Mintable-batchMint(address,uint256[])}.
    /// @dev Note: Either `batchMint` or `batchMintOnce` should be used in a given contract, but not both.
    /// @dev Reverts with {ERC721MintToAddressZero} if `to` is the zero address.
    /// @dev Reverts with {ERC721ExistingToken} if one of `tokenIds` already exists.
    /// @dev Reverts with {ERC721BurntToken} if one of `tokenIds` has been previously burnt.
    /// @dev Emits a {Transfer} event from the zero address for each of `tokenIds`.
    /// @param to Address of the new tokens owner.
    /// @param tokenIds Identifiers of the tokens to mint.
    function batchMintOnce(Layout storage s, address to, uint256[] memory tokenIds) internal {
        if (to == address(0)) revert ERC721MintToAddressZero();

        uint256 length = tokenIds.length;
        for (uint256 i; i < length; ++i) {
            uint256 tokenId = tokenIds[i];
            uint256 owner = s.owners[tokenId];
            if (_tokenExists(owner)) revert ERC721ExistingToken(tokenId);
            if (_tokenWasBurnt(owner)) revert ERC721BurntToken(tokenId);

            s.owners[tokenId] = uint256(uint160(to));

            emit Transfer(address(0), to, tokenId);
        }

        unchecked {
            s.balances[to] += length;
        }
    }

    /// @notice Unsafely mints tokens to multiple recipients once.
    /// @dev Note: This function implements {ERC721Deliverable-deliver(address[],uint256[])}.
    /// @dev Note: Either `deliver` or `deliverOnce` should be used in a given contract, but not both.
    /// @dev Reverts with {InconsistentArrayLengths} if `recipients` and `tokenIds` have different lengths.
    /// @dev Reverts with {ERC721MintToAddressZero} if one of `recipients` is the zero address.
    /// @dev Reverts with {ERC721ExistingToken} if one of `tokenIds` already exists.
    /// @dev Reverts with {ERC721BurntToken} if one of `tokenIds` has been previously burnt.
    /// @dev Emits a {Transfer} event from the zero address for each of `recipients` and `tokenIds`.
    /// @param recipients Addresses of the new tokens owners.
    /// @param tokenIds Identifiers of the tokens to mint.
    function deliverOnce(Layout storage s, address[] memory recipients, uint256[] memory tokenIds) internal {
        uint256 length = recipients.length;
        if (length != tokenIds.length) revert InconsistentArrayLengths();
        for (uint256 i; i < length; ++i) {
            address to = recipients[i];
            if (to == address(0)) revert ERC721MintToAddressZero();

            uint256 tokenId = tokenIds[i];
            uint256 owner = s.owners[tokenId];
            if (_tokenExists(owner)) revert ERC721ExistingToken(tokenId);
            if (_tokenWasBurnt(owner)) revert ERC721BurntToken(tokenId);

            s.owners[tokenId] = uint256(uint160(to));
            unchecked {
                ++s.balances[to];
            }

            emit Transfer(address(0), to, tokenId);
        }
    }

    /// @notice Burns a token by a sender.
    /// @dev Note: This function implements {ERC721Burnable-burnFrom(address,uint256)}.
    /// @dev Reverts with {ERC721NonOwnedToken} if `tokenId` is not owned by `from`.
    /// @dev Reverts with {ERC721NonApprovedForTransfer} if `sender` is not `from` and has not been approved by `from` for `tokenId`.
    /// @dev Emits a {Transfer} event with `to` set to the zero address.
    /// @param sender The message sender.
    /// @param from The current token owner.
    /// @param tokenId The identifier of the token to burn.
    function burnFrom(Layout storage s, address sender, address from, uint256 tokenId) internal {
        uint256 owner = s.owners[tokenId];
        if (!_tokenExists(owner)) revert ERC721NonExistingToken(tokenId);
        if (_tokenOwner(owner) != from) revert ERC721NonOwnedToken(from, tokenId);

        if (!_isOperatable(s, from, sender)) {
            if (!_tokenHasApproval(owner) || sender != s.approvals[tokenId]) revert ERC721NonApprovedForTransfer(sender, from, tokenId);
        }

        s.owners[tokenId] = BURNT_TOKEN_OWNER_VALUE;

        unchecked {
            // cannot underflow as balance is verified through TOKEN ownership
            --s.balances[from];
        }
        emit Transfer(from, address(0), tokenId);
    }

    /// @notice Burns a batch of tokens by a sender.
    /// @dev Note: This function implements {ERC721Burnable-batchBurnFrom(address,uint256[])}.
    /// @dev Reverts with {ERC721NonOwnedToken} if one of `tokenIds` is not owned by `from`.
    /// @dev Reverts with {ERC721NonApprovedForTransfer} if `sender` is not `from` and has not been approved by `from` for each of `tokenIds`.
    /// @dev Emits a {Transfer} event with `to` set to the zero address for each of `tokenIds`.
    /// @param sender The message sender.
    /// @param from The current tokens owner.
    /// @param tokenIds The identifiers of the tokens to burn.
    function batchBurnFrom(Layout storage s, address sender, address from, uint256[] calldata tokenIds) internal {
        bool operatable = _isOperatable(s, from, sender);

        uint256 length = tokenIds.length;
        for (uint256 i; i < length; ++i) {
            uint256 tokenId = tokenIds[i];
            uint256 owner = s.owners[tokenId];
            if (!_tokenExists(owner)) revert ERC721NonExistingToken(tokenId);
            if (_tokenOwner(owner) != from) revert ERC721NonOwnedToken(from, tokenId);
            if (!operatable) {
                if (!_tokenHasApproval(owner) || sender != s.approvals[tokenId]) revert ERC721NonApprovedForTransfer(sender, from, tokenId);
            }
            s.owners[tokenId] = BURNT_TOKEN_OWNER_VALUE;
            emit Transfer(from, address(0), tokenId);
        }

        if (length != 0) {
            unchecked {
                s.balances[from] -= length;
            }
        }
    }

    /// @notice Gets the balance of an address.
    /// @dev Note: This function implements {ERC721-balanceOf(address)}.
    /// @dev Reverts with {ERC721BalanceOfAddressZero} if `owner` is the zero address.
    /// @param owner The address to query the balance of.
    /// @return balance The amount owned by the owner.
    function balanceOf(Layout storage s, address owner) internal view returns (uint256 balance) {
        if (owner == address(0)) revert ERC721BalanceOfAddressZero();
        return s.balances[owner];
    }

    /// @notice Gets the owner of a token.
    /// @dev Note: This function implements {ERC721-ownerOf(uint256)}.
    /// @dev Reverts with {ERC721NonExistingToken} if `tokenId` does not exist.
    /// @param tokenId The token identifier to query the owner of.
    /// @return tokenOwner The owner of the token.
    function ownerOf(Layout storage s, uint256 tokenId) internal view returns (address tokenOwner) {
        uint256 owner = s.owners[tokenId];
        if (!_tokenExists(owner)) revert ERC721NonExistingToken(tokenId);
        return _tokenOwner(owner);
    }

    /// @notice Gets the approved address for a token.
    /// @dev Note: This function implements {ERC721-getApproved(uint256)}.
    /// @dev Reverts with {ERC721NonExistingToken} if `tokenId` does not exist.
    /// @param tokenId The token identifier to query the approval of.
    /// @return approved The approved address for the token identifier, or the zero address if no approval is set.
    function getApproved(Layout storage s, uint256 tokenId) internal view returns (address approved) {
        uint256 owner = s.owners[tokenId];
        if (!_tokenExists(owner)) revert ERC721NonExistingToken(tokenId);
        if (_tokenHasApproval(owner)) {
            return s.approvals[tokenId];
        } else {
            return address(0);
        }
    }

    /// @notice Gets whether an operator is approved for all tokens by an owner.
    /// @dev Note: This function implements {ERC721-isApprovedForAll(address,address)}.
    /// @param owner The address which gives the approval for all tokens.
    /// @param operator The address which receives the approval for all tokens.
    /// @return approvedForAll Whether the operator is approved for all tokens by the owner.
    function isApprovedForAll(Layout storage s, address owner, address operator) internal view returns (bool approvedForAll) {
        return s.operators[owner][operator];
    }

    /// @notice Gets whether a token was burnt.
    /// @param tokenId The token identifier.
    /// @return tokenWasBurnt Whether the token was burnt.
    function wasBurnt(Layout storage s, uint256 tokenId) internal view returns (bool tokenWasBurnt) {
        return _tokenWasBurnt(s.owners[tokenId]);
    }

    function layout() internal pure returns (Layout storage s) {
        bytes32 position = LAYOUT_STORAGE_SLOT;
        assembly {
            s.slot := position
        }
    }

    /// @notice Calls {IERC721Receiver-onERC721Received} on a target contract.
    /// @dev Reverts with {ERC721SafeTransferRejected} if the call to the target fails, reverts or is rejected.
    /// @param sender The message sender.
    /// @param from Previous token owner.
    /// @param to New token owner.
    /// @param tokenId Identifier of the token transferred.
    /// @param data Optional data to send along with the receiver contract call.
    function _callOnERC721Received(address sender, address from, address to, uint256 tokenId, bytes memory data) private {
        if (IERC721Receiver(to).onERC721Received(sender, from, tokenId, data) != ERC721_RECEIVED) revert ERC721SafeTransferRejected(to, tokenId);
    }

    /// @notice Returns whether an account is authorised to make a transfer on behalf of an owner.
    /// @param owner The token owner.
    /// @param account The account to check the operatability of.
    /// @return operatable True if `account` is `owner` or is an operator for `owner`, false otherwise.
    function _isOperatable(Layout storage s, address owner, address account) private view returns (bool operatable) {
        return (owner == account) || s.operators[owner][account];
    }

    function _tokenOwner(uint256 owner) private pure returns (address tokenOwner) {
        return address(uint160(owner));
    }

    function _tokenExists(uint256 owner) private pure returns (bool tokenExists) {
        return uint160(owner) != 0;
    }

    function _tokenWasBurnt(uint256 owner) private pure returns (bool tokenWasBurnt) {
        return owner == BURNT_TOKEN_OWNER_VALUE;
    }

    function _tokenHasApproval(uint256 owner) private pure returns (bool tokenHasApproval) {
        return owner & TOKEN_APPROVAL_OWNER_FLAG != 0;
    }
}


// File @animoca/ethereum-contracts/contracts/token/ERC721/base/ERC721Base.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;



/// @title ERC721 Non-Fungible Token Standard (proxiable version).
/// @dev This contract is to be used via inheritance in a proxied implementation.
/// @dev Note: This contract requires ERC165 (Interface Detection Standard).
abstract contract ERC721Base is IERC721, Context {
    using ERC721Storage for ERC721Storage.Layout;

    /// @inheritdoc IERC721
    function approve(address to, uint256 tokenId) external virtual {
        ERC721Storage.layout().approve(_msgSender(), to, tokenId);
    }

    /// @inheritdoc IERC721
    function setApprovalForAll(address operator, bool approved) external virtual {
        ERC721Storage.layout().setApprovalForAll(_msgSender(), operator, approved);
    }

    /// @inheritdoc IERC721
    function transferFrom(address from, address to, uint256 tokenId) external {
        ERC721Storage.layout().transferFrom(_msgSender(), from, to, tokenId);
    }

    /// @inheritdoc IERC721
    function safeTransferFrom(address from, address to, uint256 tokenId) external virtual {
        ERC721Storage.layout().safeTransferFrom(_msgSender(), from, to, tokenId);
    }

    /// @inheritdoc IERC721
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external virtual {
        ERC721Storage.layout().safeTransferFrom(_msgSender(), from, to, tokenId, data);
    }

    /// @inheritdoc IERC721
    function balanceOf(address owner) external view returns (uint256 balance) {
        return ERC721Storage.layout().balanceOf(owner);
    }

    /// @inheritdoc IERC721
    function ownerOf(uint256 tokenId) external view returns (address tokenOwner) {
        return ERC721Storage.layout().ownerOf(tokenId);
    }

    /// @inheritdoc IERC721
    function getApproved(uint256 tokenId) external view returns (address approved) {
        return ERC721Storage.layout().getApproved(tokenId);
    }

    /// @inheritdoc IERC721
    function isApprovedForAll(address owner, address operator) external view returns (bool approvedForAll) {
        return ERC721Storage.layout().isApprovedForAll(owner, operator);
    }
}


// File @animoca/ethereum-contracts/contracts/token/metadata/interfaces/ITokenMetadataResolver.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @title ITokenMetadataResolver
/// @notice Interface for Token Metadata Resolvers.
interface ITokenMetadataResolver {
    /// @notice Gets the token metadata URI for a token.
    /// @param tokenContract The token contract for which to retrieve the token URI.
    /// @param tokenId The token identifier.
    /// @return tokenURI The token metadata URI.
    function tokenMetadataURI(address tokenContract, uint256 tokenId) external view returns (string memory tokenURI);
}


// File @animoca/ethereum-contracts/contracts/token/metadata/libraries/TokenMetadataStorage.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;


library TokenMetadataStorage {
    struct Layout {
        string tokenName;
        string tokenSymbol;
        ITokenMetadataResolver tokenMetadataResolver;
    }

    bytes32 internal constant LAYOUT_STORAGE_SLOT = bytes32(uint256(keccak256("animoca.token.metadata.TokenMetadata.storage")) - 1);
    bytes32 internal constant PROXY_INIT_PHASE_SLOT = bytes32(uint256(keccak256("animoca.token.metadata.TokenMetadata.phase")) - 1);

    /// @notice Initializes the metadata storage (immutable version).
    /// @dev Note: This function should be called ONLY in the constructor of an immutable (non-proxied) contract.
    /// @param tokenName The token name.
    /// @param tokenSymbol The token symbol.
    /// @param tokenMetadataResolver The address of the metadata resolver contract.
    function constructorInit(
        Layout storage s,
        string memory tokenName,
        string memory tokenSymbol,
        ITokenMetadataResolver tokenMetadataResolver
    ) internal {
        s.tokenName = tokenName;
        s.tokenSymbol = tokenSymbol;
        s.tokenMetadataResolver = tokenMetadataResolver;
    }

    /// @notice Initializes the metadata storage (proxied version).
    /// @notice Sets the proxy initialization phase to `1`.
    /// @dev Note: This function should be called ONLY in the init function of a proxied contract.
    /// @dev Reverts with {InitializationPhaseAlreadyReached} if the proxy initialization phase is set to `1` or above.
    /// @param tokenName The token name.
    /// @param tokenSymbol The token symbol.
    /// @param tokenMetadataResolver The address of the metadata resolver contract.
    function proxyInit(
        Layout storage s,
        string calldata tokenName,
        string calldata tokenSymbol,
        ITokenMetadataResolver tokenMetadataResolver
    ) internal {
        ProxyInitialization.setPhase(PROXY_INIT_PHASE_SLOT, 1);
        s.tokenName = tokenName;
        s.tokenSymbol = tokenSymbol;
        s.tokenMetadataResolver = tokenMetadataResolver;
    }

    /// @notice Gets the name of the token.
    /// @return tokenName The name of the token contract.
    function name(Layout storage s) internal view returns (string memory tokenName) {
        return s.tokenName;
    }

    /// @notice Gets the symbol of the token.
    /// @return tokenSymbol The symbol of the token contract.
    function symbol(Layout storage s) internal view returns (string memory tokenSymbol) {
        return s.tokenSymbol;
    }

    /// @notice Gets the address of the token metadata resolver.
    /// @return tokenMetadataResolver The address of the token metadata resolver.
    function metadataResolver(Layout storage s) internal view returns (ITokenMetadataResolver tokenMetadataResolver) {
        return s.tokenMetadataResolver;
    }

    /// @notice Gets the token metadata URI retieved from the metadata resolver contract.
    /// @param tokenContract The address of the token contract.
    /// @param tokenId The ID of the token.
    function tokenMetadataURI(Layout storage s, address tokenContract, uint256 tokenId) internal view returns (string memory) {
        return s.tokenMetadataResolver.tokenMetadataURI(tokenContract, tokenId);
    }

    function layout() internal pure returns (Layout storage s) {
        bytes32 position = LAYOUT_STORAGE_SLOT;
        assembly {
            s.slot := position
        }
    }
}


// File @animoca/ethereum-contracts/contracts/token/metadata/base/TokenMetadataBase.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;


/// @title TokenMetadataBase (proxiable version).
/// @notice Provides metadata management for token contracts (ERC721/ERC1155) which uses an external resolver for managing individual tokens metadata.
/// @dev This contract is to be used via inheritance in a proxied implementation.
abstract contract TokenMetadataBase {
    using TokenMetadataStorage for TokenMetadataStorage.Layout;

    /// @notice Gets the token name. E.g. "My Token".
    /// @return tokenName The token name.
    function name() public view virtual returns (string memory tokenName) {
        return TokenMetadataStorage.layout().name();
    }

    /// @notice Gets the token symbol. E.g. "TOK".
    /// @return tokenSymbol The token symbol.
    function symbol() public view virtual returns (string memory tokenSymbol) {
        return TokenMetadataStorage.layout().symbol();
    }

    /// @notice Gets the token metadata resolver address.
    /// @return tokenMetadataResolver The token metadata resolver address.
    function metadataResolver() external view virtual returns (ITokenMetadataResolver tokenMetadataResolver) {
        return TokenMetadataStorage.layout().metadataResolver();
    }
}


// File @animoca/ethereum-contracts/contracts/token/ERC721/base/ERC721MetadataBase.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;




/// @title ERC721 Non-Fungible Token Standard, optional extension: Metadata (proxiable version).
/// @notice This contracts uses an external resolver for managing individual tokens metadata.
/// @dev This contract is to be used via inheritance in a proxied implementation.
/// @dev Note: This contract requires ERC721 (Non-Fungible Token Standard).
abstract contract ERC721MetadataBase is TokenMetadataBase, IERC721Metadata {
    using ERC721Storage for ERC721Storage.Layout;
    using TokenMetadataStorage for TokenMetadataStorage.Layout;

    /// @inheritdoc IERC721Metadata
    function name() public view virtual override(IERC721Metadata, TokenMetadataBase) returns (string memory tokenName) {
        return TokenMetadataBase.name();
    }

    /// @inheritdoc IERC721Metadata
    function symbol() public view virtual override(IERC721Metadata, TokenMetadataBase) returns (string memory tokenSymbol) {
        return TokenMetadataBase.symbol();
    }

    /// @inheritdoc IERC721Metadata
    function tokenURI(uint256 tokenId) external view virtual returns (string memory uri) {
        ERC721Storage.layout().ownerOf(tokenId); // reverts if the token does not exist
        return TokenMetadataStorage.layout().tokenMetadataURI(address(this), tokenId);
    }
}


// File @animoca/ethereum-contracts/contracts/token/ERC721/base/ERC721MintableOnceBase.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;




/// @title ERC721 Non-Fungible Token Standard, optional extension: Mintable (proxiable version)
/// @notice ERC721Mintable implementation where burnt tokens cannot be minted again.
/// @dev This contract is to be used via inheritance in a proxied implementation.
/// @dev Note: This contract requires ERC721 (Non-Fungible Token Standard).
/// @dev Note: This contract requires AccessControl.
abstract contract ERC721MintableOnceBase is IERC721Mintable, Context {
    using ERC721Storage for ERC721Storage.Layout;
    using AccessControlStorage for AccessControlStorage.Layout;

    bytes32 public constant MINTER_ROLE = "minter";

    /// @inheritdoc IERC721Mintable
    /// @dev Reverts with {NotRoleHolder} if the sender does not have the 'minter' role.
    /// @dev Reverts with {ERC721BurntToken} if `tokenId` has been previously burnt.
    function mint(address to, uint256 tokenId) external virtual {
        AccessControlStorage.layout().enforceHasRole(MINTER_ROLE, _msgSender());
        ERC721Storage.layout().mintOnce(to, tokenId);
    }

    /// @inheritdoc IERC721Mintable
    /// @dev Reverts with {NotRoleHolder} if the sender does not have the 'minter' role.
    /// @dev Reverts with {ERC721BurntToken} if `tokenId` has been previously burnt.
    function safeMint(address to, uint256 tokenId, bytes calldata data) external virtual {
        AccessControlStorage.layout().enforceHasRole(MINTER_ROLE, _msgSender());
        ERC721Storage.layout().safeMintOnce(_msgSender(), to, tokenId, data);
    }

    /// @inheritdoc IERC721Mintable
    /// @dev Reverts with {NotRoleHolder} if the sender does not have the 'minter' role.
    /// @dev Reverts with {ERC721BurntToken} if one of `tokenIds` has been previously burnt.
    function batchMint(address to, uint256[] calldata tokenIds) external virtual {
        AccessControlStorage.layout().enforceHasRole(MINTER_ROLE, _msgSender());
        ERC721Storage.layout().batchMintOnce(to, tokenIds);
    }

    /// @notice Gets whether a token was burnt.
    /// @param tokenId The token identifier.
    /// @return tokenWasBurnt Whether the token was burnt.
    function wasBurnt(uint256 tokenId) external view virtual returns (bool tokenWasBurnt) {
        return ERC721Storage.layout().wasBurnt(tokenId);
    }
}


// File @animoca/ethereum-contracts/contracts/token/ERC721/ERC721.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;



/// @title ERC721 Non-Fungible Token Standard (immutable version).
/// @dev This contract is to be used via inheritance in an immutable (non-proxied) implementation.
abstract contract ERC721 is ERC721Base, InterfaceDetection {
    /// @notice Marks the following ERC165 interfaces as supported: ERC721.
    constructor() {
        ERC721Storage.init();
    }
}


// File @animoca/ethereum-contracts/contracts/token/ERC721/ERC721Metadata.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;




/// @title ERC721 Non-Fungible Token Standard, optional extension: Metadata (immutable version).
/// @notice This contracts uses an external resolver for managing individual tokens metadata.
/// @dev This contract is to be used via inheritance in an immutable (non-proxied) implementation.
abstract contract ERC721Metadata is ERC721MetadataBase {
    using TokenMetadataStorage for TokenMetadataStorage.Layout;

    /// @notice Marks the following ERC165 interfaces as supported: ERC721Metadata.
    /// @param name The name of the token.
    /// @param symbol The symbol of the token.
    /// @param metadataResolver The address of the metadata resolver contract.
    constructor(string memory name, string memory symbol, ITokenMetadataResolver metadataResolver) {
        TokenMetadataStorage.layout().constructorInit(name, symbol, metadataResolver);
        ERC721Storage.initERC721Metadata();
    }
}


// File @animoca/ethereum-contracts/contracts/token/ERC721/ERC721MintableOnce.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;



/// @title ERC721 Non-Fungible Token Standard, optional extension: Mintable (immutable version)
/// @notice ERC721Mintable implementation where burnt tokens cannot be minted again.
/// @dev This contract is to be used via inheritance in an immutable (non-proxied) implementation.
abstract contract ERC721MintableOnce is ERC721MintableOnceBase, AccessControl {
    /// @notice Marks the following ERC165 interface(s) as supported: ERC721Mintable.
    constructor() {
        ERC721Storage.initERC721Mintable();
    }
}


// File contracts/BCNFT.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;





contract BCNFT is ContractOwnership, ERC721, ERC721Metadata, ERC721MintableOnce {
    constructor(
        ITokenMetadataResolver metadataResolver
    ) ContractOwnership(_msgSender()) ERC721() ERC721Metadata("Bonding Curve NFT", "BCNFT", metadataResolver) ERC721MintableOnce() {}
}