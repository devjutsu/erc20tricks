const { ethers, upgrades } = require("hardhat");

const PROXY = "0x5911B8AB2Ba093963d74c721477209027eb0Ce9C";

async function main() {
    const MyERC20UpgradebleV3 = await ethers.getContractFactory("MyERC20UpgradebleV3");
    console.log("Upgrading MyERC20Upgradeble...");
    await upgrades.upgradeProxy(PROXY, MyERC20UpgradebleV3);
    console.log("MyERC20Upgradeble upgraded");
}

main();