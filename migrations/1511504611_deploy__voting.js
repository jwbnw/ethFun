const Voting = artifacts.require("./Voting.sol")

module.exports = function(deployer) {
  // Use deployer to state migration tasks.
  deployer.deploy(Voting,['Bob','Alice'],{gas: 6700000});
};
