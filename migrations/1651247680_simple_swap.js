const Migrations = artifacts.require("./SimpleSwap.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
