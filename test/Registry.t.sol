// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Registry} from "../src/Registry.sol";


/*
    Test code for /src/Registry.sol
 */

contract RegistryTest is Test {
    Registry registry;
    address alice;

    uint256 public constant MIN_PRICE = 1 ether;
    uint256 public constant ETHER_10 = 10 ether;

    function setUp() public {
        alice = makeAddr("alice");
        
        registry = new Registry();
    }

    function test_register() public {
        uint256 amountToPay = registry.PRICE();
        
        vm.deal(alice, amountToPay);
        vm.startPrank(alice);

        uint256 aliceBalanceBefore = address(alice).balance;

        registry.register{value: amountToPay}();

        uint256 aliceBalanceAfter = address(alice).balance;
        
        assertTrue(registry.isRegistered(alice), "Did not register user");
        assertEq(address(registry).balance, registry.PRICE(), "Unexpected registry balance");
        assertEq(aliceBalanceAfter, aliceBalanceBefore - registry.PRICE(), "Unexpected user balance");
    }

    /** Code your fuzz test here */
     /** Almost the same test, but this time fuzzing amountToPay detects the bug (the Registry
         contract is not giving back the change) */
    function test_ReturnChange(uint256 amountToPay) public {
        
        vm.assume(amountToPay >= 1 ether);
        vm.deal(alice, amountToPay);
        vm.startPrank(alice);

        uint256 aliceBalanceBefore = address(alice).balance;
        registry.register{value: amountToPay}();

        uint256 aliceBalanceAfter = address(alice).balance;
        
        assertTrue(registry.isRegistered(alice), "Did not register user");
        assertEq(address(registry).balance, registry.PRICE(), "Unexpected registry balance");
        assertEq(aliceBalanceAfter, aliceBalanceBefore - registry.PRICE(), "Unexpected user balance");
    }
}