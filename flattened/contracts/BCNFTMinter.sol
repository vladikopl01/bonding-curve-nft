// Sources flattened with hardhat v2.22.5 https://hardhat.org

// SPDX-License-Identifier: MIT

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


// File @animoca/ethereum-contracts/contracts/introspection/errors/InterfaceDetectionErrors.sol@v4.0.0-rc.0

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Thrown when setting the illegal interfaceId 0xffffffff.
error IllegalInterfaceId();


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


// File @openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol@v4.9.6

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.4) (token/ERC20/extensions/IERC20Permit.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 Permit extension allowing approvals to be made via signatures, as defined in
 * https://eips.ethereum.org/EIPS/eip-2612[EIP-2612].
 *
 * Adds the {permit} method, which can be used to change an account's ERC20 allowance (see {IERC20-allowance}) by
 * presenting a message signed by the account. By not relying on {IERC20-approve}, the token holder account doesn't
 * need to send a transaction, and thus is not required to hold Ether at all.
 *
 * ==== Security Considerations
 *
 * There are two important considerations concerning the use of `permit`. The first is that a valid permit signature
 * expresses an allowance, and it should not be assumed to convey additional meaning. In particular, it should not be
 * considered as an intention to spend the allowance in any specific way. The second is that because permits have
 * built-in replay protection and can be submitted by anyone, they can be frontrun. A protocol that uses permits should
 * take this into consideration and allow a `permit` call to fail. Combining these two aspects, a pattern that may be
 * generally recommended is:
 *
 * ```solidity
 * function doThingWithPermit(..., uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) public {
 *     try token.permit(msg.sender, address(this), value, deadline, v, r, s) {} catch {}
 *     doThing(..., value);
 * }
 *
 * function doThing(..., uint256 value) public {
 *     token.safeTransferFrom(msg.sender, address(this), value);
 *     ...
 * }
 * ```
 *
 * Observe that: 1) `msg.sender` is used as the owner, leaving no ambiguity as to the signer intent, and 2) the use of
 * `try/catch` allows the permit to fail and makes the code tolerant to frontrunning. (See also
 * {SafeERC20-safeTransferFrom}).
 *
 * Additionally, note that smart contract wallets (such as Argent or Safe) are not able to produce permit signatures, so
 * contracts should have entry points that don't rely on permit.
 */
interface IERC20Permit {
    /**
     * @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
     * given ``owner``'s signed approval.
     *
     * IMPORTANT: The same issues {IERC20-approve} has related to transaction
     * ordering also apply here.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `deadline` must be a timestamp in the future.
     * - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
     * over the EIP712-formatted function arguments.
     * - the signature must use ``owner``'s current nonce (see {nonces}).
     *
     * For more information on the signature format, see the
     * https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
     * section].
     *
     * CAUTION: See Security Considerations above.
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    /**
     * @dev Returns the current nonce for `owner`. This value must be
     * included whenever a signature is generated for {permit}.
     *
     * Every successful call to {permit} increases ``owner``'s nonce by one. This
     * prevents a signature from being used multiple times.
     */
    function nonces(address owner) external view returns (uint256);

    /**
     * @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}


// File @openzeppelin/contracts/token/ERC20/IERC20.sol@v4.9.6

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
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


// File @openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol@v4.9.6

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.3) (token/ERC20/utils/SafeERC20.sol)

pragma solidity ^0.8.0;



/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using Address for address;

    /**
     * @dev Transfer `value` amount of `token` from the calling contract to `to`. If `token` returns no value,
     * non-reverting calls are assumed to be successful.
     */
    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    /**
     * @dev Transfer `value` amount of `token` from `from` to `to`, spending the approval given by `from` to the
     * calling contract. If `token` returns no value, non-reverting calls are assumed to be successful.
     */
    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    /**
     * @dev Increase the calling contract's allowance toward `spender` by `value`. If `token` returns no value,
     * non-reverting calls are assumed to be successful.
     */
    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 oldAllowance = token.allowance(address(this), spender);
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, oldAllowance + value));
    }

    /**
     * @dev Decrease the calling contract's allowance toward `spender` by `value`. If `token` returns no value,
     * non-reverting calls are assumed to be successful.
     */
    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, oldAllowance - value));
        }
    }

    /**
     * @dev Set the calling contract's allowance toward `spender` to `value`. If `token` returns no value,
     * non-reverting calls are assumed to be successful. Meant to be used with tokens that require the approval
     * to be set to zero before setting it to a non-zero value, such as USDT.
     */
    function forceApprove(IERC20 token, address spender, uint256 value) internal {
        bytes memory approvalCall = abi.encodeWithSelector(token.approve.selector, spender, value);

        if (!_callOptionalReturnBool(token, approvalCall)) {
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, 0));
            _callOptionalReturn(token, approvalCall);
        }
    }

    /**
     * @dev Use a ERC-2612 signature to set the `owner` approval toward `spender` on `token`.
     * Revert on invalid signature.
     */
    function safePermit(
        IERC20Permit token,
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) internal {
        uint256 nonceBefore = token.nonces(owner);
        token.permit(owner, spender, value, deadline, v, r, s);
        uint256 nonceAfter = token.nonces(owner);
        require(nonceAfter == nonceBefore + 1, "SafeERC20: permit did not succeed");
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address-functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        require(returndata.length == 0 || abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     *
     * This is a variant of {_callOptionalReturn} that silents catches all reverts and returns a bool instead.
     */
    function _callOptionalReturnBool(IERC20 token, bytes memory data) private returns (bool) {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We cannot use {Address-functionCall} here since this should return false
        // and not revert is the subcall reverts.

        (bool success, bytes memory returndata) = address(token).call(data);
        return
            success && (returndata.length == 0 || abi.decode(returndata, (bool))) && Address.isContract(address(token));
    }
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


// File contracts/lib/minter/ERC721/ERC721Minter.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;




/// @title ERC721 Minter contract (immutable version).
abstract contract ERC721Minter is ERC721MinterBase, InterfaceDetection {
    using ERC721MinterStorage for ERC721MinterStorage.Layout;

    /// @notice Initializes the storage with the maximum token ID and the ERC721 token contract.
    /// @dev Reverts with {ERC721MinterZeroMaxTokenId} if the `maxTokenId` is zero.
    /// @dev Reverts with {ERC721MinterZeroTokenAddress} if the `token` is the zero address.
    /// @dev Reverts with {ERC721MinterUnsupportedContractType} if the `token` does not support the IERC721Mintable interface.
    /// @param maxTokenId The maximum token ID that can be minted.
    /// @param token The ERC721 token contract.
    constructor(uint256 maxTokenId, IERC721Mintable token) {
        ERC721MinterStorage.layout().constructorInit(maxTokenId, token);
    }
}


// File contracts/BCNFTMinter.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.24;







contract BCNFTMinter is ERC721Minter, Context {
    using SafeERC20 for IERC20;

    ICurve public curve;
    IERC20 public feeToken;
    address public feeReceiver;

    error InvalidCurveContractType(address curveContract);

    error ZeroAddress();

    constructor(ICurve _curve, IERC20 _feeToken, address _feeReceiver, uint256 maxTokenId, IERC721Mintable token) ERC721Minter(maxTokenId, token) {
        if (!IERC165(address(_curve)).supportsInterface(type(ICurve).interfaceId)) {
            revert InvalidCurveContractType(address(_curve));
        }
        curve = _curve;
        feeToken = _feeToken;
        if (_feeReceiver == address(0)) {
            revert ZeroAddress();
        }
        feeReceiver = _feeReceiver;
    }

    function mint(address to) public override {
        uint256 price = curve.calculatePrice(currentTokenId(), 1);
        feeToken.safeTransferFrom(_msgSender(), feeReceiver, price);
        super.mint(to);
    }
}