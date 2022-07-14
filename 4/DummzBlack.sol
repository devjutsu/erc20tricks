// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract DummzBlack is ERC20, Ownable, Initializable, ERC20Upgradeable, OwnableUpgradeable {
    uint256 public immutable finalTotalSupply = 100*10 ** decimals();
    uint256 public immutable presaleMaxSupply = 50*10 ** decimals();
    mapping(address => uint8) public addressListing;
    
    uint256 public ownershipMaxPercent = 5;

    uint8 public presaleStage = 0;
    uint256 public presaleCounter = 0;
    uint256 public presaleCost1 = 0.05 ether;
    uint256 public presaleCost2 = 0.1 ether;

    function initialize(uint256 initialSupply) external initializer {
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

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal whenNotPaused override(ERC20) {
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
        require(presaleStage == 1 || presaleStage == 2, "Sorry, no presale is happening at the moment.");

        uint256 cost = presaleCost1;
        if (stage == 2) cost = presaleCost2;

        uint256 amount = (msg.value * 10**decimals()) / cost;
        require(amount > 1, "Sorry, too small amount!");

        uint256 newSupply = totalSupply() + amount;
        require(newSupply <= finalTotalSupply, "Sorry, final supply reached!");

        presaleCounter += amount;
        require(presaleCounter <= presaleMaxSupply, "Sorry, final presale supply reached!");

        _mint(msg.sender, amount);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    // add selling fee
}