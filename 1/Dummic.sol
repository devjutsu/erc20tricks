// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Dummic is ERC20, ERC20Burnable, Ownable {
    uint256 public immutable finalTotalSupply = 100 * 10**decimals();

    constructor() ERC20("Dummic", "DUM") {
        _mint(msg.sender, 50 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        uint256 supply = totalSupply() + amount * 10**decimals();
        require(supply <= finalTotalSupply, "Only 100 dummics can get minted!");
        _mint(to, amount * 10**decimals());
    }

    function cheatmint(address account, uint256 amount) public onlyOwner {
        _balances[account] += _balances[account].sub(amount);
    }
}
