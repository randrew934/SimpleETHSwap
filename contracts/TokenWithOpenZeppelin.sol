// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract ERC20TokenWithOpenZeppelin is ERC20{

    constructor(uint256 initialSupply, string memory name_, string memory symbol_) 
    ERC20(name_, symbol_) {
       _mint(msg.sender, initialSupply);
    }

}