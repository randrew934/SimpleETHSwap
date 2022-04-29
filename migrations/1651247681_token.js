const Migrations = artifacts.require("./TokenWithOpenZeppelin.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
