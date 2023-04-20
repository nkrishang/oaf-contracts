// ananthjj
// 04/20/2023
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "oaf-contracts/lib/forge-std/src/Test.sol";
import "oaf-contracts/src/exercise-3/Escrow.sol";

contract EscrowTest is Test {
    Escrow escrow;
    address alice;
    uint256 bobEther;
    IERC20 aToken;

    function beforeEach() override public {
        bobEther = 1 ether;
        alice = address(this);
        escrow = new Escrow(alice, bobEther, address(aToken), 10);
        aToken = IERC20(escrow.expectedCurrency());
        aToken.transfer(alice, 100); // Give Alice 100 A-Tokens to use for testing
        aToken.approve(address(escrow), 10); // Approve the escrow to spend Alice's A-Tokens
    }

    function test_executeEscrow() public {
        uint256 aliceStartingBalance = aToken.balanceOf(alice);
        uint256 bobStartingBalance = address(this).balance;

        // Alice executes the escrow by sending 10 A-Tokens to the escrow contract
        escrow.executeEscrow{value: bobEther}();

        uint256 aliceEndingBalance = aToken.balanceOf(alice);
        uint256 bobEndingBalance = address(this).balance;

        assertEqual(aliceStartingBalance - 10, aliceEndingBalance, "Alice did not send the expected number of A-Tokens");
        assertEqual(bobStartingBalance + bobEther, bobEndingBalance, "Bob did not receive the expected amount of ether");
    }

    function test_withdrawAfterTimeout() public {
        // Set up the escrow with a very short timeout for testing
        escrow = new Escrow(alice, bobEther, address(aToken), 1);
        aToken.approve(address(escrow), 10);

        uint256 bobStartingBalance = address(this).balance;

        // Wait for the escrow timeout to elapse
        sleep(2);

        // Bob can now withdraw the ether from the escrow
        escrow.withdraw();

        uint256 bobEndingBalance = address(this).balance;

        assertEqual(bobStartingBalance + bobEther, bobEndingBalance, "Bob did not receive the expected amount of ether");
    }

    function test_withdrawBeforeTimeout() public {
        // Set up the escrow with a very long timeout for testing
        escrow = new Escrow(alice, bobEther, address(aToken), 10000);
        aToken.approve(address(escrow), 10);

        // Bob cannot withdraw the ether until the timeout elapses
        bool success = address(escrow).call(abi.encodeWithSignature("withdraw()"));
        assertEqual(false, success, "Bob was able to withdraw before the timeout elapsed");
    }

    function test_insufficientCurrency() public {
        // Set up the escrow with an insufficient amount of A-Tokens approved
        aToken.approve(address(escrow), 5);

        // Alice cannot execute the escrow with an insufficient amount of A-Tokens
        bool success = address(escrow).call{value: bobEther}(abi.encodeWithSignature("executeEscrow()"));
        assertEqual(false, success, "Alice was able to execute the escrow without sufficient currency");
    }

    function test_insufficientEther() public {
        // Set up the escrow with insufficient ether deposited by Bob
        bobEther = 0.5 ether;
        escrow = new Escrow(alice, bobEther, address(aToken), 10);
        aToken.approve(address(escrow), 10);
        
        // Alice cannot execute the escrow with insufficient ether deposited by Bob
        bool success = address(escrow).call{value: bobEther}(abi.encodeWithSignature("executeEscrow()"));
        assertEqual(false, success, "Alice was able to execute the escrow without sufficient ether deposited by Bob");
    }
}
