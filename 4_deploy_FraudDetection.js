const FraudDetection = artifacts.require("FraudDetection");

module.exports = async function (deployer) {
  await deployer.deploy(FraudDetection);
};
