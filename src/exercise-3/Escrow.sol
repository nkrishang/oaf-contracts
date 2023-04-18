// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
 *  Exercise: Bob and Alice are entering an escrow. Alice wants to exchange 10 A-Tokens for 1 ether from Bob.
 *            Alice and Bob don't trust each other, so they use a smart contract to execute this exchange.
 *
 *            [1] Write an ESCROW smart contract that does the following:
 *
 *              - In the constructor:
 *                  - Let Bob deposit a given amount of ether into the smart contract.
 *                  - Store escrow details: 
 *                      (a) the address of Alice 
 *                      (b) the expected currency + amount that Alice must deposit to get the ether stored in the contract by Bob
 *                      (c) the amount of time Bob is willing to wait for Alice to execute the escrow.
 *
 *              - Allow Alice to execute the escrow by by sending the expected currency + amount to the contract,
 *                to receive the stored ether in exchange.
 *
 *              - If Alice hasn't executed the escrow within the time that Bob expects, let Bob withdraw the ether stored in the contract.
 *
 *            [2] Since Alice and Bob don't trust each other, they want to make sure that the smart contract
 *                is not malicious. So -- deploy the smart contract to the Goerli blockchain and verify it.
 *
 *  HINT: You can use the IERC20 contract to represent the A-Tokens.
**/

contract Escrow {}