// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


import {S5Pool} from "./S5Pool.sol";
import {S5Token} from "../test/mocks/S5Token.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {console} from "lib/forge-std/src/console.sol";


contract S5 {
    using SafeERC20 for S5Token;

    error S5__InvariantInTact();

    S5Token private s_tokenA;
    S5Token private s_tokenB;
    S5Token private s_tokenC;
    S5Pool private s_pool;
    uint256 private immutable i_initialTotalTokens;
    address private immutable i_randomPoolOwner;
    uint256 private constant PRECISION = 1e18;
    uint256 public constant AMOUNT100 = PRECISION * 100;
    uint256 public constant INITIAL_SUPPLY = PRECISION * 1000;

    constructor(address randomOwner) {
        i_randomPoolOwner = randomOwner;
        _setupPoolAndTokens();
        // We should always get at least this many tokens back
        i_initialTotalTokens = s_tokenA.INITIAL_SUPPLY() + s_tokenB.INITIAL_SUPPLY();
    }

    /*
     * CALL THIS FUNCTION!
     * 
     * @dev Try to break the invariant of the pool!
     * 
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(string memory twitterHandle) external {
        s_pool.redeem(uint64(block.timestamp));
        if (s_tokenA.balanceOf(address(this)) + s_tokenB.balanceOf(address(this)) >= i_initialTotalTokens) {
            // revert S5__InvariantInTact();
            console.log("s5-solve failed - redeem");
        }
        _setupPoolAndTokens();
        // _updateAndRewardSolver(twitterHandle);

        // console.log("_setupPoolAndTokens");
    }    


    function getPool() external view returns (address) {
        return address(s_pool);
    }

    function getTokenA() external view returns (address) {
        return address(s_tokenA);
    }

    function getTokenB() external view returns (address) {
        return address(s_tokenB);
    }

    function getTokenC() external view returns (address) {
        return address(s_tokenC);
    }


    // ------------ My Functions, should be replaced in real example ---------
    function reedem() external {
        s_pool.redeem(uint64(block.timestamp));
    }

   function swapAll() external {
        s_pool.swapFrom(s_tokenA, s_tokenB, PRECISION);
        s_pool.swapFrom(s_tokenB, s_tokenC, PRECISION);
    }
    // ------------------------------------------------------------------------


    /*
     * @dev Every time this challenge is solved, we reset the challenge by creating a new pool and tokens.
     * @dev I was going to self destruct after every new challenge... but that opcode might be unsupported in the future
     * @dev then i was going to do proxies but didn't want to make it too hard...
     * @dev so... we are just laying carnage to arbitrum deploying a ton of contracts
     */
    function _setupPoolAndTokens() private {
        s_tokenA = new S5Token("A");
        s_tokenB = new S5Token("B");
        s_tokenC = new S5Token("C");
        // For gas savings
        S5Token tokenA = s_tokenA;
        S5Token tokenB = s_tokenB;
        S5Token tokenC = s_tokenC;

        s_pool = new S5Pool(tokenA, tokenB, tokenC);
        S5Pool pool = s_pool;
        pool.transferOwnership(i_randomPoolOwner);

        tokenA.approve(address(pool), type(uint256).max);
        tokenB.approve(address(pool), type(uint256).max);
        tokenC.approve(address(pool), type(uint256).max);
        pool.deposit(tokenA.INITIAL_SUPPLY(), uint64(block.timestamp));

        /* NPA Comment: 
            At this point balances are:
                Total Supply Pool:    1000_000000000000000000
                PoolTokenBalances A:  1000_000000000000000000
                PoolTokenBalances B:  1000_000000000000000000
                PoolTokenBalances C:  1000_000000000000000000
        */
    }

    /*
     * @dev Want a do over? Try a hard reset!
     */
    function hardReset() external {
        _setupPoolAndTokens();
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////// The following are functions needed for the NFT, feel free to ignore. ///////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////

    function specialImage() external pure returns (string memory) {
        // This is b5.png
        return "ipfs://QmbmTmE6kTYiAFm5e1oUZEbK2hDKeu9kadUqPk8hF2XtXU";
    }
}


