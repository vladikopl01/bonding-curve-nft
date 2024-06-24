// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC721Minter} from "../interfaces/IERC721Minter.sol";
import {ERC721MinterStorage} from "../libraries/ERC721MinterStorage.sol";

abstract contract ERC721MinterBase is IERC721Minter {
    using ERC721MinterStorage for ERC721MinterStorage.Layout;

    function currentId() public override view returns (uint256 tokenId) {
        return ERC721MinterStorage.layout().currentId();
    }

    function maxId() external override view returns (uint256 tokenId) {
        return ERC721MinterStorage.layout().maxId();
    }

    function mint(address to) public override virtual {
        ERC721MinterStorage.layout().mint(to);
    }
}
