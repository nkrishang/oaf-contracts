// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
 *  Exercise: Write a smart contract that does the following:
 *      1. Maintains a balance sheet of addresses -> to amounts.
 *      2. Gives the deployer of the contract a balance of 10_000 at the time of contract creation.
 *      3. Allows an address to transfer its balance to another address.
**/

contract BalanceSheet {
    // 1. Maintain a balance sheet of addresses -> to amounts.
    mapping(address => uint256) public balances;

    // 2. Give the deployer of the contract a balance of 10_000 at the time of contract creation.
    constructor() {
        balances[msg.sender] = 10_000;
    }

    // 3. Allow an address to transfer its balance to another address.
    function transfer(address to, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}