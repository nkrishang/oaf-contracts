// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
 *  Exercise: Write an ESCROW smart contract that does the following:
 *      - In the constructor:
 *              - let the deployer deposit an amount of ether.
 *              - store escrow details: the address of the other participant, and the expected currency + amount
 *                this participant must deposit to release the ether stored in the contract.
 *
 *      - Allow the other participant to execute the escrow by by sending the expected currency + amount to
 *        the contract deployer, and receive the ether stored by the contract -- all in ONE transaction.
**/