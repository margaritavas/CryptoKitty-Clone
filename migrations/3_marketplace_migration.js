const token = artifacts.require("kittyContract");
const Marketplace = artifacts.require("KittyMarketplace");

module.exports = function (deployer) {
  deployer.deploy(Marketplace, token.address);
};
