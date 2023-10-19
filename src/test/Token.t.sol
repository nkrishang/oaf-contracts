// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "lib/forge-std/src/Test.sol";
import "src/exercise-2/Token.sol";

contract TokenTest is Test {
    address deployer = address(0x12345);
    address spender = address(0x54321);
    Token token;

    function setUp() public {
        token = new Token();

        vm.prank(deployer);
        token.mint(1000);
    }

    function test_supplt() public {
        assertEq(token.totalSupply(), 1000);
    }

    function test_balance_deployer() public {
        assertEq(token.balanceOf(deployer), 1000);
    }

    function test_balance_spender() public {
        assertEq(token.balanceOf(spender), 0);
    }

    function test_transfer() public {
        vm.prank(deployer);
        token.transfer(spender, 50);

        assertEq(token.balanceOf(deployer), 950);
        assertEq(token.balanceOf(spender), 50);
    }

    function test_allowance() public {
        vm.prank(deployer);
        token.approve(spender, 100);

        assertEq(token.allowance(deployer, spender), 100);
    }

    function test_allowance_transfer() public {
        vm.prank(spender);
        token.transferFrom(deployer, spender, 100);

        assertEq(token.allowance(deployer, spender), 0);

        assertEq(token.balanceOf(deployer), 850);
        assertEq(token.balanceOf(spender), 150);
    }

    function test_burn() public {
        vm.prank(deployer);
        token.burn(850);

        assertEq(token.totalSupply(), 0);
        assertEq(token.balanceOf(deployer), 0);
        assertEq(token.balanceOf(spender), 150);
    }
}