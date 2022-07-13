const { ethers, upgrades } = require("hardhat");

const PROXY = "0x1603b959ABd232B5037766ABfeebf9BAa3B7D3e3";

async function main() {
    const MyERC20UpgradebleV3 = await ethers.getContractFactory("MyERC20UpgradebleV3");
    console.log("Upgrading Dummix...");
    await upgrades.upgradeProxy(PROXY, MyERC20UpgradebleV3);
    console.log("MyERC20Upgradeble upgraded");
}

main();