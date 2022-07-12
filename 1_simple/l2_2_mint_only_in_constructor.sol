// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        uint256 percent100=initialSupply * 10 ** decimals();
        _mint(msg.sender, percent100 * 80 / 100);
        _mint(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, percent100 * 15 / 100);
        _mint(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db, percent100 * 5 / 100);
    }

    /*function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount * 10 ** decimals());
    }*/
}