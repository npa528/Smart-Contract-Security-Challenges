// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import { Test, console2 } from "forge-std/Test.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { StdInvariant } from "forge-std/StdInvariant.sol";
import {S5Pool} from "../../src/S5Pool.sol";
import {S5Token} from "../mocks/S5Token.sol";
import{Handler} from "./Handler.t.sol";

contract Invariant is StdInvariant, Test {
    S5Pool s_pool;
    S5Token s_tokenA;
    S5Token s_tokenB;
    S5Token s_tokenC;

    address user = makeAddr("user");
    Handler handler;

    function setUp() public {
        vm.startPrank(user);

        s_tokenA = new S5Token("A");
        s_tokenB = new S5Token("B");
        s_tokenC = new S5Token("C");
        // For gas savings
        S5Token tokenA = s_tokenA;
        S5Token tokenB = s_tokenB;
        S5Token tokenC = s_tokenC;

        vm.stopPrank();

        s_pool = new S5Pool(tokenA, tokenB, tokenC);
    
        handler = new Handler(s_pool, tokenA, tokenB, tokenC, user);

        bytes4[] memory selectors = new bytes4[](2);
        selectors[0] = handler.depositTokenA.selector;
        selectors[1] = handler.withdrawTokenA.selector;

        targetSelector(FuzzSelector({addr: address(handler), selectors: selectors}));
        targetContract(address(handler));
    }


    function statefulFuzz_testInvariantBreaksHandler() public {
        vm.startPrank(user);

        s_pool.redeem(uint64(block.timestamp));
        
        vm.stopPrank();

        assert(s_tokenA.balanceOf(address(s_pool)) == 0);
        assert(s_tokenB.balanceOf(address(s_pool)) == 0);
        assert(s_tokenC.balanceOf(address(s_pool)) == 0);
    
        assert(s_tokenA.balanceOf(user) == s_tokenA.INITIAL_SUPPLY());
        assert(s_tokenB.balanceOf(user) == s_tokenB.INITIAL_SUPPLY());
        assert(s_tokenC.balanceOf(user) == s_tokenC.INITIAL_SUPPLY());
    }
}

