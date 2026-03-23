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

contract Test {
    struct Data {
        uint64 a;
        uint64 b;
        uint256 c;
        bool d;
    }

    mapping(address => Data) public data;
    
}

contract Solve2 {
    struct Data {
        uint256 c ;
        uint64 a ;
        uint64 b ;
        bool d ;
    }

    mapping (address => Data ) public data ;

}

