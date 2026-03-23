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

bytes32 baseSlot = keccak256(abi.encode(msg.sender, uint256(0)));

slot 0: balance (16) | debt (16)
slot 1: isActive (1) | padding (31)

function readUser(address user) public view returns (uint128 balance, uint128 debt, bool isActive) {
    bytes32 baseSlot = keccak256(abi.encode(user, uint256(0)));

    assembly {
        let slotData := sload(baseSlot)
        balance := shr(128, slotData)        // üst 16 byte
        debt := and(slotData, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF) // alt 16 byte
        isActive := sload(add(baseSlot, 1)) // yeni slot
    }
}