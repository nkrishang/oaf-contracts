// ananthjj
// 04/20/2023
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
 *            [2] Create a file `src/test/Escrow.t.sol` and write test cases for the Escrow smart contract.
 *
 *            [3] Since Alice and Bob don't trust each other, they want to make sure that the smart contract
 *                is not malicious. So -- deploy the smart contract to the Goerli blockchain and verify it.
 *
 *  HINT: You can use the IERC20 contract to represent the A-Tokens.
**/

import "oaf-contracts/src/exercise-2/IERC20.sol";

contract Escrow {
    address payable public bob;
    address public alice;
    IERC20 public token;
    uint public amount;
    uint public deadline;
    bool public executed;
    
    constructor(address _bob, address _alice, address _token, uint _amount, uint _deadline) {
        bob = payable(_bob);
        alice = _alice;
        token = IERC20(_token);
        amount = _amount;
        deadline = _deadline;
        executed = false;
    }
    
    function execute() external {
        require(msg.sender == alice, "Only Alice can execute the escrow");
        require(!executed, "The escrow has already been executed");
        
        uint balance = token.balanceOf(alice);
        require(balance >= amount, "Insufficient token balance");
        
        bool success = token.transferFrom(alice, address(this), amount);
        require(success, "Token transfer failed");
        
        bob.transfer(address(this).balance);
        executed = true;
    }
    
    function withdraw() external {
        require(msg.sender == bob, "Only Bob can withdraw the escrowed ether");
        require(block.timestamp >= deadline, "The deadline has not yet been reached");
        require(!executed, "The escrow has already been executed");
        
        bob.transfer(address(this).balance);
        executed = true;
    }
}
