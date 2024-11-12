const { ethers, upgrades } = require('hardhat');

async function main() {
  const VendingMachineV2 = await ethers.getContractFactory('VendingMachineV2');
  const proxy = await upgrades.deployProxy(VendingMachineV2, [100]);
  await proxy.waitForDeployment();

  // console.log(proxy)
  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    proxy.target
  );

  console.log('Proxy contract address: ' + proxy.target);

  console.log('Implementation contract address: ' + implementationAddress);
}

main();