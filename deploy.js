const hre = require("hardhat");

async function main() {
  // Fetch the contract factory
  const LandRegistry = await hre.ethers.getContractFactory("LandRegistry");

  // Deploy the contract
  const contract = await LandRegistry.deploy();
  await contract.waitForDeployment(); // Fix: Use waitForDeployment() instead of deployed()

  // Get deployed contract address
  console.log(`Contract deployed to: ${await contract.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
