// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./IERC20.sol";

/**
 *  Exercise: [1] Write a smart contract that implements the ERC-20 standard.
 *            [2] Create a file `src/test/Token.t.sol` and write test cases for your ERC-20 smart contract.
 *                Look at the test case for exercise-1 as reference.
 *                
**/

contract Token is IERC20 {
    uint public supply;
    mapping(address => uint) balance;
    mapping(address => mapping(address => uint)) allowanceOf;
    
    function totalSupply() external view returns (uint256){
        return supply;
    }

    function balanceOf(address account) external view returns (uint256){
        return balance[account];
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        balance[msg.sender] -= amount;
        balance[to] += amount;

        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256)
    {
        return allowanceOf[owner][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool)
    {
        allowanceOf[msg.sender][spender] += amount;
        emit Approval(msg.sender, spender, amount);

        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool)
    {
        allowanceOf[from][msg.sender] -= amount;
        balance[from] -= amount;
        balance[to] += amount;

        emit Transfer(from, to, amount);

        return true;
    }

    // Saw these functions implemented on Solidity by Example

    function mint(uint amount) external {
        balance[msg.sender] += amount;
        supply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        balance[msg.sender] -= amount;
        supply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}