// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract DummzBlack is Initializable, ERC20Upgradeable, OwnableUpgradeable {
    uint256 public immutable finalTotalSupply = 1000*10 ** decimals();
    uint256 public immutable presaleMaxSupply = 500*10 ** decimals();
    uint256 public immutable ownershipMaxPercent = 5;
    mapping(address => uint8) public addressListing;
    
    uint8 public presaleStage;
    uint256 public presaleCounter;
    uint256 public presaleInitialCost;


    function initialize(uint256 initialSupply) external initializer {
        presaleStage = 0;
        presaleCounter = 0;
        presaleInitialCost = 0.01 ether;

        __ERC20_init("DummzBlack", "DUB");
        __Ownable_init();
        _mint(msg.sender, initialSupply*10**decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        uint256 newSupply=totalSupply()+amount * 10 ** decimals();
        require(newSupply<=finalTotalSupply,"Final supply reached!");
        _mint(to, amount * 10 ** decimals());
    }

    function isBlacklisted(address _user) public view returns (bool) {
        if(addressListing[_user] == 2) {
            return true;
        }
        return false;
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override(ERC20Upgradeable) {
        super._beforeTokenTransfer(from, to, amount);
        require(!isBlacklisted(msg.sender), "Sorry, this user is blacklisted!");

        if(to != owner()) {
            uint256 ownershipPercent = ((balanceOf(to) + amount) * 100) / finalTotalSupply;
            require(ownershipPercent <= ownershipMaxPercent, "Sorry, you can't have so many tokens!");
        }
    }

    function blacklist(address _user) external {
        addressListing[_user] = 2;
    }

    function removeBlacklist(address _user) external {
        addressListing[_user] = 0;
    }

    function setStage(uint8 _stage) public onlyOwner {
        presaleStage = _stage;
    }

    function withdraw() public onlyOwner {
        (bool os, ) = payable(owner()).call{value: address(this).balance}("");
        require(os);
    }

    function buyOnPresale() public payable {
        require(presaleStage > 0, "Sorry, no presale is happening at the moment.");

        uint256 cost = presaleInitialCost * (10 ** presaleStage);
        
        uint256 amount = (msg.value * 10**decimals()) / cost;
        require(amount > 1, "Sorry, too small amount!");

        uint256 newSupply = totalSupply() + amount;
        require(newSupply <= finalTotalSupply, "Sorry, final supply reached!");

        presaleCounter += amount;
        require(presaleCounter <= presaleMaxSupply, "Sorry, final presale supply reached!");

        _mint(msg.sender, amount);
    }

    // add selling fee
}