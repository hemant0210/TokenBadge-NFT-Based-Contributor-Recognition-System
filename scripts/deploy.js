const hre = require("hardhat");

async function main() {
  const TokenBadge = await hre.ethers.getContractFactory("TokenBadge");
  const tokenBadge = await TokenBadge.deploy();
  await tokenBadge.deployed();

  console.log("TokenBadge deployed to:", tokenBadge.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
