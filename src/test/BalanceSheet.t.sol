// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "lib/forge-std/src/Test.sol";
import "src/exercise-1/BalanceSheet.sol";

contract BalanceSheetTest is Test {
    
    address deployer = address(0x12345);
    BalanceSheet balanceSheet;

    function setUp() public {
        vm.prank(deployer);
        balanceSheet = new BalanceSheet(10_000);
    }

    function test_initial_balance() public {
        assertEq(balanceSheet.balance(deployer), 10_000);
    }

    function test_transfer() public {
        address recipient = address(0x456);

        vm.prank(deployer);
        balanceSheet.transfer(recipient, 1_000);

        assertEq(balanceSheet.balance(deployer), 9_000);
        assertEq(balanceSheet.balance(recipient), 1_000);
    }
}