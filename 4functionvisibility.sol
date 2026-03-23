//SPDX-License-MIT
pragma solidity ^0.8.20;

contract visibility {
    uint private secret = 42 ;
    uint internal counter = 0 ;
    uint public data = 10 ;

    function add(uint x) public returns(uint) {
        counter += x ;
        return counter ;
    }

    function multiply(uint x) external view returns(uint) {
        return data * x ;
    }

    function incrementCounter() internal {
        counter += 1 ;
    }

    function secretNum() private view returns(uint) {
        return secret ;
    }

    function callInternal() public {
        incrementCounter();
    }

    function revealSecret() public view returns(uint){
        return secretNum(); 
    }
}