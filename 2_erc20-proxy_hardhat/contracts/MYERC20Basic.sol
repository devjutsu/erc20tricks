// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestToken1 is ERC20 {
    constructor(uint256 initialSupply) ERC20("TestToken1", "TTK1") {
            _mint(msg.sender, initialSupply*10**decimals());
    }
}