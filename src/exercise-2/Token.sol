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
    mapping(address => uint256) sheet;
    uint256 token_supply;
    mapping(address => mapping(address=> uint256)) allowances;

    function totalSupply() external view returns (uint256) {
        return token_supply;
    }

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256) {
        return sheet[account];
    }

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool) {
        return _transfer(from, to, amount);
    }

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256) {
        return allowances[owner][spender];
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool) {
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        if(msg.sender != from) {
            require(allowances[from][msg.sender] >= amount, "TransferFrom: caller does not have enough allowance to send on behalf of from");
            allowances[from][to] -= amount;
        }
        
        return _transfer(from, to, amount);
    }

    function _transfer(address from, address to, uint256 amount) internal returns (bool) {
        require(sheet[from] >= amount, "TransferFrom: from address does not have enough tokens");

        sheet[from] -= amount;
        sheet[to] += amount;
        
        emit Transfer(from, to, amount);
        return true;
    }
}