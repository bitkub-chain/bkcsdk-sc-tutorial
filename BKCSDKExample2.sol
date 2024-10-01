// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.8.20;

import "./ITarget.sol";
import "./ISDKTransferRouter.sol";

contract BKCSDKExample2 {
    address public constant SDK_CALL_HELPER_ROUTER = 0x96f4C25E4fEB02c8BCbAdb80d0088E0112F728Bc;
    ISDKTransferRouter public constant SDK_TRANSFER_ROUTER = ISDKTransferRouter(0xAE7D33f10f09669A86e45BAA6342377aFf4cF728);

    uint256 public myUint256Var = 7216;
    string[] public myStringArrVar; // appendable array
    mapping(address => uint8) public myAddrToUint8Map;

    modifier onlySDKCallHelperRouter() {
        require(msg.sender == SDK_CALL_HELPER_ROUTER, "BKCSDKExample2: restricted only sdk call helper router");
        _;
    }

    event MySDKMethod1Executed(address indexed bitkubNext, address indexed var1, uint256 var2, string var3);

    function mySDKMethod1(
        address var1_,
        uint256 var2_,
        string memory var3_,
        address bitkubNext_
    ) external onlySDKCallHelperRouter {
        myAddrToUint8Map[var1_] = uint8(block.timestamp % type(uint8).max);
        myUint256Var = var2_;
        myStringArrVar.push(var3_);

        emit MySDKMethod1Executed(bitkubNext_, var1_, var2_, var3_);
    }

    event MySDKMethod2Executed(address indexed bitkubNext, address[] addressArr);

    function mySDKMethod2(
        address[] memory addressArr_,
        address bitkubNext_
    ) public onlySDKCallHelperRouter {
        for (uint256 i = 0; i < addressArr_.length; i++) {
            myAddrToUint8Map[addressArr_[i]] = uint8((block.timestamp + i) % type(uint8).max);
        }

        emit MySDKMethod2Executed(bitkubNext_, addressArr_);
    }

    // Ethers.js v6
    // const { AbiCoder } = require('ethers');
    // const abiCoder = new AbiCoder();

    // const res = abiCoder.encode(
    //     ['address[]'],
    //     [['0xd9145CCE52D386f254917e481eB44e9943F39138', '0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8']],
    // );
    // console.log(res);

    function mySDKMethod2(
        bytes memory abiEncodedAddressArr_,
        address bitkubNext_
    ) external onlySDKCallHelperRouter {
        address[] memory addressArr;
        (addressArr) = abi.decode(abiEncodedAddressArr_, (address[]));

        mySDKMethod2(addressArr, bitkubNext_);
    }

    function mySDKMethod3(address target_, uint256 a_, address) external onlySDKCallHelperRouter returns (uint256) {
        return ITarget(target_).setA(a_);
    }

    function mySDKMethod4(
        address tokenAddr_,
        address recipient_,
        uint256 amount_,
        address bitkubNext_
    ) external onlySDKCallHelperRouter {
        SDK_TRANSFER_ROUTER.transferKAP20(tokenAddr_, recipient_, amount_, bitkubNext_);
    }

    function mySDKMethod5(
        address tokenAddr_,
        address recipient_,
        uint256 tokenId_,
        address bitkubNext_
    ) external onlySDKCallHelperRouter {
        SDK_TRANSFER_ROUTER.transferKAP721(tokenAddr_, recipient_, tokenId_, bitkubNext_);
    }
}