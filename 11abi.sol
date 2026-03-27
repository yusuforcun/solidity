// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AbiBasics {
    function encodeData(uint256 x , string memory text) public pure returns (bytes memory){
        return abi.encode(x,text);
    }

    function decodeData(bytes memory data) public pure returns(uint256 , string memory){
        return abi.decode(data , (uint256 , string));
    }

    function normalEncode() public pure returns (bytes memory){
        return abi.encode("ab","c");
    }

    function packedEncode() public pure returns (bytes memory){
        return abi.encodePacked("ab","c");
    }
    function packedCollision1() public pure returns (bytes memory){
        return abi.encodePacked("a","bc");
    }
}