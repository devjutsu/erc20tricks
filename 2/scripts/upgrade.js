const { ethers, upgrades } = require("hardhat");

async function main() {
    const Dummix2 = await ethers.getContractFactory("DummixV2");
    console.log("Deploying Dummix v2...");
    const dummix2 = await upgrades.upgradeProxy('0x84B27Ff64b1b4f6bDCbe76114023f0e4dda74c77', Dummix2);
    await dummix2.deployed();
    console.log("Dummix2 deployed to:", dummix2.address);


}

main();