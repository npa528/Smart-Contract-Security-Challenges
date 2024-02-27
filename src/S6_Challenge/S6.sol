// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {S6Token} from "../../test/mocks/S6Token.sol";
import {S6Market} from "./S6Market.sol";
import { Ownable } from "./Ownable.sol";
import {console} from "lib/forge-std/src/console.sol";

interface WhoAreYou {
    function owner() external view returns (address);
}

contract S6 is Ownable {
    using SafeERC20 for S6Token;

    error S6__WhoAreYou();
    error S6__BuyMeLamboPlz();
    error S6__YouGottaDepositToWithdraw();
    error S6___updateAndRewardSolver(); // this actually is Winner response!

    S6Token private immutable i_s6token;
    S6Market private immutable i_market;
    mapping(address => uint256) private s_balances;
    uint256 public constant S6_NFT_COST = 2_000_000e18; 


    constructor() Ownable(msg.sender) {
        i_s6token = new S6Token();
        i_market = new S6Market(address(i_s6token));
        i_s6token.safeTransfer(address(i_market), i_s6token.balanceOf(address(this)));
    }

    /*
     * CALL THIS FUNCTION
     * 
     * Ok all, I've turned to the dark side. You can only have this NFT if you 
     * all deposit 1,000,000 S6Tokens into this contract. Daddy needs a Lambo.  
     * 
     * The S6Market contract has a function that will allow you to buy 1,000,000 S6Tokens 
     * for 1,000,000 ETH. Really a bargain price for such a cool NFT, ya feel me? 
     * 
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(string memory twitterHandle) external view {
       
        if (WhoAreYou(msg.sender).owner() != address(msg.sender)) {
            revert S6__WhoAreYou();
        }
        
        if (i_s6token.balanceOf(address(this)) >= S6_NFT_COST) {
            // _updateAndRewardSolver(twitterHandle);
            
            //revert S6___updateAndRewardSolver();
            console.log("update and reward but continue...");
        } else {
            revert S6__BuyMeLamboPlz();
        }
    }

    function depositMoney(uint256 amount) external {
        s_balances[msg.sender] += amount;
        i_s6token.safeTransferFrom(msg.sender, address(this), amount);
    }

    function withdrawMoney() external {
        if (s_balances[msg.sender] == 0) {
            revert S6__YouGottaDepositToWithdraw();
        }
        uint256 balanceToReturn = s_balances[msg.sender];
        s_balances[msg.sender] = 0;
        i_s6token.safeTransfer(msg.sender, balanceToReturn);
    }

    function ownerWithdrawMoney() external onlyOwner {
        i_s6token.safeTransfer(owner(), i_s6token.balanceOf(address(this)));
    }

    function getToken() external view returns (address) {
        return address(i_s6token);
    }

    function getMarket() external view returns (address) {
        return address(i_market);
    }

    function getBalance(address user) external view returns (uint256) {
        return s_balances[user];
    }
}