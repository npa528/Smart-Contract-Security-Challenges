// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import { Test, console2 } from "forge-std/Test.sol";
import {S5Pool} from "../../src/S5Pool.sol";
import {S5Token} from "../mocks/S5Token.sol";


contract Handler  is Test {
    S5Pool private s_pool;
    S5Token private s_tokenA;
    S5Token private s_tokenB;
    S5Token private s_tokenC;
    address private i_randomPoolOwner;
    address user;

    constructor(S5Pool _spool, S5Token _tokenA, S5Token _tokenB, S5Token _tokenC, address _user) {
        s_pool = _spool;
        s_tokenA = _tokenA;
        s_tokenB = _tokenB;
        s_tokenC = _tokenC;
        user = _user;
    }

    function depositTokenA(uint256 _amount) public {
        uint256 amount = bound(_amount, 1, 1e18);
        vm.startPrank(user);

        s_tokenA.approve(address(s_pool),s_tokenA.INITIAL_SUPPLY());
        s_tokenB.approve(address(s_pool), s_tokenB.INITIAL_SUPPLY());
        s_tokenC.approve(address(s_pool), s_tokenC.INITIAL_SUPPLY());

        s_tokenA.approve(user, s_tokenA.INITIAL_SUPPLY());
        s_tokenB.approve(user, s_tokenB.INITIAL_SUPPLY());
        s_tokenC.approve(user, s_tokenC.INITIAL_SUPPLY());
        
        s_pool.deposit(amount, uint64(block.timestamp));
        vm.stopPrank();
    }


    function withdrawTokenA() public {
        vm.startPrank(user);
        s_pool.redeem(uint64(block.timestamp));
        vm.stopPrank();
    }
}