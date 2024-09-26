// SPDX-License-Identifier: MIT

pragma solidity >=0.4.0 <0.9.0;

interface ITarget {
    function setA(uint256 a_) external returns (uint256);
}