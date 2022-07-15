const { ethers, upgrades } = require("hardhat");

async function main() {
    await hre.run('compile');
    
    const Dummz = await ethers.getContractFactory("DummzBlack");
    console.log("Deploying Dummz...");
    const dummz = await upgrades.deployProxy(Dummz, [100], {
        initializer: "initialize",
    });
    await dummz.deployed();
    console.log("Dummix1 deployed to:", dummz.address);
    
}

main();