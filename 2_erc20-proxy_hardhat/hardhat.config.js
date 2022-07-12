require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");
require("@nomiclabs/hardhat-etherscan");
require('dotenv').config();

module.exports = {
  solidity: "0.8.15",
  networks: {
    rinkeby: {
      url: 'https://rinkeby.infura.io/v3/749c7c4e8f6543cf85b40be1f5fe4e72',
      accounts: [process.env.PRIVATE_KEY],
    },
    polygon: {
      url: 'https://polygon-rpc.com',
      accounts:[process.env.PRIVATE_KEY],
    }
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
};
