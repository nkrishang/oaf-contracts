// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
 *  Exercise: Write a smart contract that does the following:
 *      1. Maintains a balance sheet of addresses -> to amounts.
 *      2. Gives the deployer of the contract a balance of 10_000 at the time of contract creation.
 *      3. Allows an address to transfer its balance to another address.
**/

contract BalanceSheet {

    uint public balance;
    address public deployer;

    constructor(uint _balance, address _deployer) {
        balance = _balance;
        deployer = _deployer;

        balance = 10000;
        deployer = msg.sender;
    }

    mapping(address => uint256) public balances;

    // Adding the current ether amount to balances[msg.sender]
    function deposit () public payable{
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function tansferBalance(address payable recipent) public {
        uint256 balance = address(this).balance;
        recipent.transfer(balance);
    }
}

