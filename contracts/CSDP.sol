// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract CSDP is ERC20, ERC20Permit, Ownable, ReentrancyGuard {
    uint256 public tokenPrice;
    uint256 private totalTokenSupply;

    constructor(uint256 price) 
        ERC20("CSDP", "CSDP") 
        ERC20Permit("CSDP")
        Ownable(0xa0b8234297c8c9BA5f2e0B9d84791232ef1B78A9) // Specify the Ownable constructor
    {
        totalTokenSupply = 1000000000000000000000000;
        tokenPrice = price;
        totalTokenSupply -= 100000000000000000000;
        _mint(0xa0b8234297c8c9BA5f2e0B9d84791232ef1B78A9, 100000000000000000000);
    }

    // This function will be called whenever Ether is sent to the contract
    receive() external payable nonReentrant {
        require(msg.value > 0, "You must send Ether to mint tokens");
        
        uint256 amountToMint = msg.value / tokenPrice; // Calculate amount of tokens to mint
        require(amountToMint > 0, "Insufficient Ether sent for minting tokens");
        require(totalTokenSupply > 0, "No more tokens can be minted");
        
        totalTokenSupply -= amountToMint;
        _mint(msg.sender, amountToMint); // Mint tokens to the sender
    }

    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance); // Withdraw Ether from the contract
    }

    function setTokenPrice(uint256 newPrice) public onlyOwner {
        tokenPrice = newPrice; // Update the token price
    }
     
    function transfer(address to, uint256 value) override public returns (bool) {
        _burn(address(0), value*2/100000); // burn 0.002% of the token on every txn
        return super.transfer(to, value);
    }
}
