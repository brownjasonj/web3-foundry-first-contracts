// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

contract MockERC20 is ERC20 {
    constructor() ERC20("Mock Token", "MTK") {}

    function mint(address _to, uint256 _amount) public {
        _mint(_to, _amount);
    }
}