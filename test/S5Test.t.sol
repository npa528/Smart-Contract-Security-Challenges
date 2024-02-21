// // SPDX-License-Identifier: MIT
// pragma solidity 0.8.20;

// import { Test, console } from "forge-std/Test.sol";
// import { S5 } from "../src/S5.sol";


// contract S5Test is Test {
//     S5 s5;
//     address private owner;
//     address user = makeAddr("user");

//     function setUp() public {
//         owner = msg.sender;
//         s5 = new S5(owner);
//     }

//     function testCreatePool() public {
//         address poolAddress = factory.createPool(address(tokenA));
//         assertEq(poolAddress, factory.getPool(address(tokenA)));
//         assertEq(address(tokenA), factory.getToken(poolAddress));
//     }

//     function testCantCreatePoolIfExists() public {
//         factory.createPool(address(tokenA));
//         vm.expectRevert(abi.encodeWithSelector(PoolFactory.PoolFactory__PoolAlreadyExists.selector, address(tokenA)));
//         factory.createPool(address(tokenA));
//     }
// }