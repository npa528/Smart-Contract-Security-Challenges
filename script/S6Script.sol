// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import {S6} from "../src/S6_Challenge/S6.sol";
import {S6Token} from "../test/mocks/S6Token.sol";

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {S6Token} from "../../test/mocks/S6Token.sol";
import {S6Market} from "../src/S6_Challenge/S6Market.sol";
import {console} from "lib/forge-std/src/console.sol";


contract S6Script is Script {
    S6 public s6;

    function run() public {
        s6 = new S6();

        s6.solveChallenge("dsadsa");

        // console.log("owner: ", s6.owner()); // 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496
    }

    function owner() external view returns (address) {
        return address(this);
    }

}