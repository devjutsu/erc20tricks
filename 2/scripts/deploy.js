const { ethers, upgrades } = require("hardhat");

async function main() {
    const Dummix = await ethers.getContractFactory("Dummix");
    console.log("Deploying Dummix...");
    const box = await upgrades.deployProxy(Dummix, [100], {
        initializer: "initialize",
    });
    await box.deployed();
    console.log("Dummix deployed to:", box.address);
}

main();