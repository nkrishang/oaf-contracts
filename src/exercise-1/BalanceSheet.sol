// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
 *  Exercise: Write a smart contract that does the following:
 *      1. Maintains a balance sheet of addresses -> to amounts.
 *      2. Gives the deployer of the contract a balance of 10_000 at the time of contract creation.
 *      3. Allows an address to transfer its balance to another address.
**/

contract BalanceSheet {
    
    // ========== State ==========

    mapping(address => uint256) public balance;
    
    // ========== Constructor ==========

    constructor(uint256 initialBalance) {
        balance[msg.sender] = initialBalance;
    }

    // ========== External functions  ==========

    function transfer(address to, uint256 amount) external {
        require(balance[msg.sender] >= amount, "Insufficient balance");
        balance[msg.sender] -= amount;
        balance[to] += amount;
    }
}
