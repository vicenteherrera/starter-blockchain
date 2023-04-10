// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.2 <0.9.0;

contract Bytes32ToString {

    function bytes32ToStr(bytes32 _bytes32) public pure returns (string memory) {
        // string memory str = string(_bytes32);
        // TypeError: Explicit type conversion not allowed from "bytes32" to "string storage pointer"
        // thus we should fist convert bytes32 to bytes (to dynamically-sized byte array)

        bytes memory bytesArray = new bytes(32);
        for (uint256 i; i < 32; i++) {
            bytesArray[i] = _bytes32[i];
            }
        return string(bytesArray);
    }

    function StrToBytes32(string memory _string) public pure returns (bytes32) {
        bytes32 result = bytes32(bytes(_string));
        return result;
    }
    // [0x3100000000000000000000000000000000000000000000000000000000000000, 0x3200000000000000000000000000000000000000000000000000000000000000, 0x3300000000000000000000000000000000000000000000000000000000000000]
}
