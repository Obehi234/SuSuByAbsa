require("@nomicfoundation/hardhat-toolbox");

// Go to https://infura.io/, sign up, create a new API key
// in its dashboard, and replace "KEY" with it
const INFURA_API_KEY = "f5e57da62a49472099d94c1aedbdd114";

// Replace this private key with your Sepolia account private key
// To export your private key from Coinbase Wallet, go to
// Settings > Developer Settings > Show private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Beware: NEVER put real Ether into testing accounts
const SEPOLIA_PRIVATE_KEY = "95d0c9d019793cd2bda39f93064aa60bbf64ca9abba40c22566effc5524b3cb6";

module.exports = {
  solidity: "0.8.19",
  etherscan: {
    apiKey: {
      sepolia: 'X37WCS9YJEDSMDD7UEPS1WZ9GS76M2XBQQ'
    }
  },
  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA_API_KEY}`,
      accounts: [SEPOLIA_PRIVATE_KEY],
    },
  },
};