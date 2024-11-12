const { ethers, upgrades } = require('hardhat');

// TO DO: Place the address of your proxy here!
const proxyAddress = '0xB89D735168933e4Baa8f2618c159634692354BDf';

async function main() {
  const VendingMachineV2 = await ethers.getContractFactory('VendingMachineV2');
  const upgraded = await upgrades.upgradeProxy(proxyAddress, VendingMachineV2);

  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    proxyAddress
  );
console.log()
  console.log("The current contract owner is: " +  upgraded.owner());
  console.log('Implementation contract address: ' + implementationAddress);
}

main();