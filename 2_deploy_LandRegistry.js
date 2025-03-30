const LandRegistry = artifacts.require("LandRegistry");

module.exports = async function (deployer) {
  await deployer.deploy(LandRegistry);
};
