const { ethers, upgrades } = require("hardhat");

async function main() {
    const Dummix = await ethers.getContractFactory("Dummix");
    console.log("Deploying MyERC20Upgradeble...");
    const box = await upgrades.deployProxy(Dummix, [10000], {
        initializer: "initialize",
    });
    await box.deployed();
    console.log("Dummix deployed to:", box.address);
}

main();