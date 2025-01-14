// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract VendingMachineV2 is Initializable {
    // these state variables and their values
    // will be preserved forever, regardless of upgrading
    uint public numSodas;
    address public owner;
    mapping(address => uint) public purchasedSoda;

    function initialize(uint _numSodas) public initializer {
        numSodas = _numSodas;
        owner = msg.sender;
    }

    function purchaseSoda() public payable {
        require(msg.value >= 1000 wei, "You must pay 1000 wei for a soda!");
        numSodas--;
        purchasedSoda[msg.sender] += 1;
    }
    function withdrawProfits() public onlyOwner {
        require(
            address(this).balance > 0,
            "profits must be greater than 0 inorder to withdraw!"
        );
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent, "Failed to send ether");
    }
    function setNewOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function. ");
        _;
    }
}
