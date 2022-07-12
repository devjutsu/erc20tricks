const { ethers, upgrades } = require("hardhat");

async function main() {
    const MyERC20UpgradebleV1uups = await ethers.getContractFactory("MyERC20UpgradebleV1uups");
    console.log("Deploying MyERC20Upgradeble...");
    const box = await upgrades.deployProxy(MyERC20UpgradebleV1uups, [10000], {
        initializer: "initialize",
        kind: 'uups'
    });
    await box.deployed();
    console.log("MyERC20Upgradeble deployed to:", box.address);
}

main();

//Если не хотите верифицировать имплементацию
//просто задеплойте через этот скрипт 
//env $(cat .env) npx hardhat run --network rinkeby scripts/deploy-V1-uups.js
//и не верифицируйте
//пример контракта https://rinkeby.etherscan.io/address/0x69f140e752f4a45e44676000645ca304755cf915#code
//и его имплементации https://rinkeby.etherscan.io/address/0xf2415e47a934740f9dbbeb670a31300f6b8dc8b6#code