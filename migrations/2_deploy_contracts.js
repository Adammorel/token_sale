const token1 = artifacts.require("seedz.sol");

module.exports = function (deployer) {
  deployer.deploy(token1, 1000000);
};
