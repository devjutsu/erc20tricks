const { ethers, upgrades } = require("hardhat");

async function main() {
    const Dummix = await ethers.getContractFactory("MyERC20UpgradebleV1");
    console.log("Deploying Dummix...");
    const box = await upgrades.deployProxy(Dummix, [100], {
        initializer: "initialize",
    });
    await box.deployed();
    console.log("Dummix deployed to:", box.address);
}

main();