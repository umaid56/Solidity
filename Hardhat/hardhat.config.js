/**
 * @type import('hardhat/config').HardhatUserConfig
 */

 

  const alchmey_API_key = "";
  const ropsten_Private_key = "";
require("@nomiclabs/hardhat-waffle")
module.exports = {
  solidity: "0.8.3",

  networks : {
    ropsten : {
      url : `https://eth-ropsten.alchemyapi.io/v2/${alchmey_API_key}`,
      accounts : [`0x${ropsten_Private_key}`] ,
    },
  },

};
