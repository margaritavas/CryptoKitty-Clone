const token = artifacts.require("kittyContract");

module.exports = function (deployer) {
  deployer.deploy(token);
};
