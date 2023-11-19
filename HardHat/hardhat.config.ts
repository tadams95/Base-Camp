import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-deploy";
import dotenv from "dotenv";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  namedAccounts: {
    deployer: 0,
  },
  networks: {
    base_goerli: {
      url: `https://base-goerli.g.alchemy.com/v2/${
        process.env.ALCHEMY_BASE_GOERLI_KEY ?? ""
      }`,
      accounts: {
        mnemonic: process.env.MNEMONIC ?? "",
      },
      verify: {
        etherscan: {
          apiUrl: "https://api-goerli.basescan.org",
          apiKey: "PLACEHOLDER",
        },
      },
    },
    goerli: {
      url: `https://eth-goerli.g.alchemy.com/v2/${
        process.env.ALCHEMY_GOERLI_KEY ?? ""
      }`,
      accounts: {
        mnemonic: process.env.MNEMONIC ?? "",
      },
    },
    hardhat: {
      forking: {
        url: `https://eth-mainnet.g.alchemy.com/v2/${
          process.env.ALCHEMY_MAINNET_KEY ?? ""
        }`,
        enabled: true,
      },
    },
  },
};

export default config;
