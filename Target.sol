// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ITarget.sol";

contract Target is ITarget {
    uint256 public a;

    function setA(uint256 a_) external returns (uint256) {
        a = a_;
        return a_ + 1;
    }
}