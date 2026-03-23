// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Users {
    struct User {
        string name ;
        uint age ;
    }

    mapping(address => User) public users ;

    function register(string memory _name , uint _age) public {
        users[msg.sender] = User(_name , _age) ;
    }

    function getMyInfo() public view returns (string memory , uint){
        User memory user = users[msg.sender];
        return (user.name , user.age);
    }

    function changeAgeg(uint _newAge) public {
        users[msg.sender].age = _newAge ;
    }


    mapping(address => User) public users ;
    mapping(address => bool) public registered ;

    function registerOrUpdate(string memory _name , uint _age) public {
        if(registered[msg.sender] == false){
            require(registered[msg.sender], "No registered!");
            users[msg.sender] = User(_name , _age);
            registered[msg.sender] = true ;
        } else {
            users[msg.sender].age = _age ;
        }
    }


}