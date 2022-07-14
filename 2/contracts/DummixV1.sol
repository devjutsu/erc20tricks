//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract DummixV1 is Initializable, ERC20Upgradeable, OwnableUpgradeable {
    /*constructor(uint256 initialSupply) ERC20("Dummix", "DUM") {
            _mint(msg.sender, initialSupply*10**decimals());
    }*/

    function initialize(uint256 initialSupply) external initializer {
        __ERC20_init("Dummix", "DUM");
        __Ownable_init();
        _mint(msg.sender, initialSupply*10**decimals());
    }
}