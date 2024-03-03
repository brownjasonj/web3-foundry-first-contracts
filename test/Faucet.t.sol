// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

import {console} from "forge-std/console.sol";
import {stdStorage, StdStorage, Test} from "forge-std/Test.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import {Utils} from "./utils/Utils.sol";
import {Faucet} from "../src/Faucet.sol";
import {MockERC20} from "./MockERC20.sol";

contract BaseSetup is Test {
    Utils internal utils;
    Faucet internal faucet;
    MockERC20 internal token;

    address payable[] internal users;
    address internal owner;
    address internal dev;
    uint256 internal faucetBal = 1000;

    function setUp() public virtual {
        utils = new Utils();
        users = utils.createUsers(2);
        owner = users[0];
        vm.label(owner, "Owner");
        dev = users[1];
        vm.label(dev, "Developer");

        token = new MockERC20();
        faucet = new Faucet(IERC20(token));
        token.mint(address(faucet), faucetBal);
    }
}

contract FaucetTest is BaseSetup {
    uint256 amountToDrip = 1;

    function setUp() public override {
        super.setUp();
    }

    function test_drip_transferToDev() public {
        console.log(
            "Should transfer tokens to recipient when `drip()` is called"
        );
        uint256 _inititalDevBal = token.balanceOf(dev);

        /// Make sure that initial dev balance is Zero
        assertEq(_inititalDevBal, 0);

        /// Request some tokens to the dev wallet from the wallet
        faucet.drip(dev, amountToDrip);

        uint256 _devBalAfterDrip = token.balanceOf(dev);

        /// The difference should be equal to the amount requested from the faucet
        assertEq(_devBalAfterDrip - _inititalDevBal, amountToDrip);
    }
}