require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");
require("@nomiclabs/hardhat-etherscan");

module.exports = {
  solidity: "0.8.15",
  networks: {
    rinkeby: {
      url: 'https://rinkeby.infura.io/v3/de09eed5ccef4bc48a6caef64560b42e',
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
