// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.8.20;

contract BKCSDKExample1 {
    uint256 public myUint256Var = 7216;
    address public myAddressVar;

    function mySDKMethod1(
        uint256 var_,
        address bitkubNext_
    ) external {
        myUint256Var = var_;
        myAddressVar = bitkubNext_;
    }
}