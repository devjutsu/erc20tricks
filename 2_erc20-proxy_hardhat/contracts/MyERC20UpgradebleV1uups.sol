// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract MyERC20UpgradebleV1uups is Initializable, ERC20Upgradeable, OwnableUpgradeable, UUPSUpgradeable {

    function initialize(uint256 initialSupply) initializer public {
        __ERC20_init("MyToken", "MTK");
        __Ownable_init();
        __UUPSUpgradeable_init();
        _mint(msg.sender, initialSupply*10**decimals());

    }

    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}
}