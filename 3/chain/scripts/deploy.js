const hre = require("hardhat");
require('dotenv').config();

async function main() {
  await hre.run('compile');
  
  const Dummix = await hre.ethers.getContractFactory("Dummix");
  const dummix = await Dummix.deploy();
  await dummix.deployed();
  console.log("Dummix deployed to:", dummix.address);

  const Presale = await hre.ethers.getContractFactory("Presale");
  const presale = await Presale.deploy(dummix.address);
  await presale.deployed();
  console.log("Presale deployed to:", presale.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
