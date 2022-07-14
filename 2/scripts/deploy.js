const { ethers, upgrades } = require("hardhat");

async function main() {
    await hre.run('compile');
    
    const Dummix1 = await ethers.getContractFactory("DummixV1");
    console.log("Deploying Dummix v1...");
    const dummix1 = await upgrades.deployProxy(Dummix1, [100], {
        initializer: "initialize",
    });
    await dummix1.deployed();
    console.log("Dummix1 deployed to:", dummix1.address);

    
}

main();