// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import {S5} from "../src/S5.sol";
import "../src/S5Pool.sol";
import {S5Token} from "../test/mocks/S5Token.sol";

contract S5Script is Script {
    // Contract instances
    S5 s5;
    S5Pool s5Pool;
    S5Token s5TokenA;
    S5Token s5TokenB;
    S5Token s5TokenC;
    uint256 private constant PRECISION = 1e18;

    function run() public {
        // Deploy contracts
        s5 = new S5(msg.sender); // Replace address(1) with the registry address
        s5TokenA = S5Token(s5.getTokenA());
        s5TokenB = S5Token(s5.getTokenB());
        s5TokenC = S5Token(s5.getTokenC());
        s5Pool = S5Pool(s5.getPool());

        // Check user balances after setup (you can replace address(1) with desired user addresses)      

        // localBalances();
        // poolBalances();
        // getBalancesFromS5();

        mintTokensAndDeposit();
        reedemToLocal();
        
        localBalances();
        poolBalances();
        getBalancesFromS5();

        swap();

        reedemToSolveChallenge();
        

        localBalances();
        poolBalances();
        getBalancesFromS5();

        // You can add further tests here, like simulating deposits and checking balances again
    }


    function reedemToLocal() internal {
        console.log("reedemToLocal...");
        
        s5Pool.redeem(uint64(block.timestamp));

        console.log("-----------------------------"); 
    }

    function reedemToSolveChallenge() internal {
        console.log("Redeeming...");

        s5.solveChallenge("dsdsa");
        
        console.log("-----------------------------"); 
    }


    function mintTokensAndDeposit() internal {
        console.log("Mint and Deposit tokens");

        s5TokenA.mint(address(this));
        s5TokenB.mint(address(this));
        s5TokenC.mint(address(this));

        s5TokenA.approve(address(s5Pool), type(uint256).max);
        s5TokenB.approve(address(s5Pool), type(uint256).max);
        s5TokenC.approve(address(s5Pool), type(uint256).max);

        // s5.deposit();
        s5Pool.deposit(PRECISION, uint64(block.timestamp)); // OK

        console.log("-----------------------------");
    }

    function swap() internal {
        console.log("Swapping...");
        
        s5Pool.swapFrom(s5TokenC, s5TokenA, PRECISION); 
        s5Pool.swapFrom(s5TokenA, s5TokenB, PRECISION); 

        console.log("-----------------------------");
    }


     function getBalancesFromS5() public view {
         uint256 balanceA = s5TokenA.balanceOf(address(s5));
         uint256 balanceB = s5TokenB.balanceOf(address(s5));
         uint256 balanceC = s5TokenC.balanceOf(address(s5));
         uint256 totalAB = balanceA + balanceB;

        console.log("The balance in S5 is: ");
        console.log("Token A: ", balanceA);
        console.log("Token B: ", balanceB);
        console.log("Token C: ", balanceC);
        console.log("TotalAB: ", totalAB);
        console.log("-----------------------------"); 
    }


    function localBalances() internal view {
        uint256 balanceA = s5TokenA.balanceOf(address(this));
        uint256 balanceB = s5TokenB.balanceOf(address(this));
        uint256 balanceC = s5TokenC.balanceOf(address(this));

        console.log("Local Balances: ");
        console.log("Token A here:", balanceA);
        console.log("Token B here:", balanceB);
        console.log("Token C here:", balanceC);
        console.log("-----------------------------");
    }

    function poolBalances() internal view {
        (uint256 tA, uint256 tB, uint256 tC) = s5Pool.getPoolTokenBalances2();
        console.log("Balances in Pool:");
        console.log("Token A: ", tA);
        console.log("Token B: ", tB);
        console.log("Token C: ", tC);
        console.log("-----------------------------");
    }
}