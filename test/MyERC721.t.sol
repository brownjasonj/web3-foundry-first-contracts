// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

import  "forge-std/Test.sol";
import "../src/MyERC721.sol";

contract MyERC721Test is Test  {
    MyERC721 myERC721;
    address bob = address(0x1);
    address alice = address(0x2);


    function testMintToken() public {
        myERC721 = new MyERC721();
        myERC721.mint(bob, 1);
        assertEq(myERC721.ownerOf(1), bob);

    }

    function testTransferToken() public {
        myERC721 = new MyERC721();
        myERC721.mint(bob, 0);

        vm.startPrank(bob);
        myERC721.safeTransferFrom(bob, alice, 0);
        vm.stopPrank();
        assertEq(myERC721.ownerOf(0), alice);
    }

    function testGetBalance() public {
        myERC721 = new MyERC721();
        myERC721.mint(bob, 0);
        myERC721.mint(bob, 1);
        myERC721.mint(bob, 2);
        myERC721.mint(bob, 3);
        myERC721.mint(bob, 4);

        assertEq(myERC721.balanceOf(bob), 5);
    }

    function testOnlyOwnerBurn() public {
        myERC721 = new MyERC721();
        myERC721.mint(bob, 0);
        assertEq(myERC721.balanceOf(bob), 1);
        vm.startPrank(alice);
        myERC721.burn(0);
        vm.stopPrank();

    }
}