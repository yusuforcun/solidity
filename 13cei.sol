// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CEIExample1 {
    mapping (address => uint) public balances ;

    function deposit() external payable {
        balances[msg.sender] += value ;
    }

    function withdraw (uint amount) external {

        require(balances[msg.sender] >= amount , "Insufficient balance");

        balances[msg.sender] -= amount ;

        (bool success,) = msg.sender.call{value:amount}{""};
        require(success , "Transfer failed");
    }
}