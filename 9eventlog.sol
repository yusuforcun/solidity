// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract eventlog {
    event Deposit(address indexed user , uint amount) ; // in indexed area we can use filter and speeding up log research

    function deposit() external payable {
        require(msg.value > 0 , "Invalid amount");
        emit Deposit(msg.sender , msg.value);
    }
}