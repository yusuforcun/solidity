// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ether {
    function deposit () external payable {
        require(balance[msg.sender] >= amount,"Insufficient balance");

        balance[msg.sender] -= amount ;

        payable (msg.sender).transfer(amount);
    }

    function receive () external payable{
        bool success = payable(msg.sender).send(amount);
        require(success , "Send failed");
    }

    fallback() external payable {
        (bool success) = payable(msg.sender).call{value : amount}("");
        require(success,"Call failed");
    }
}