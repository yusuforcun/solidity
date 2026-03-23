//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BadStorage {
    uint256 public totalSupply ;  //32 byte
    bool public paused;           // 1 byte
    uint256 public maxSupply;     // 32 byte
    bool public initialized;      // 1 byte
    address public owner;         // 20 byte
}

contract GoodStorage {
    uint256 public totalSupply ; 
    uint256 public maxSupply ;
    address public owner ;
    bool public initialized ;
    bool public paused ;
}

contract Challenge {
    uint128 public a;
    uint256 public b;
    uint128 public c;
    bool public d;
    address public e;
}

contract Solve {
    bool public d ;
    address public e ;
    uint128 public a ;
    uint128 public c ;
    uint256 public b ;
}