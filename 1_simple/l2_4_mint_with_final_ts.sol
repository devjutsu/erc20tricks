// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    uint256 public immutable finalTotalSupply =10000*10 ** decimals();

    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        uint256 newSupply=totalSupply()+amount * 10 ** decimals();
        require(newSupply<=finalTotalSupply,"Final supply reached!");
        _mint(to, amount * 10 ** decimals());
    }
}
