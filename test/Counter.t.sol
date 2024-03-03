// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import  "forge-std/Test.sol";
import "../src/Counter.sol";

contract ContractTest is Test {
    function test_increment() public {
        Counter counter = new Counter(0);
        counter.increment();
        assertEq(counter.getCount(), 1);
    }
}