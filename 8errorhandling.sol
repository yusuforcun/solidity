// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract error{
    function withdraw (uint amount) public {
        require(amount > 0 , "Amount must be bigger than zero ");
        require(balance[msg.sender] >= amount , "Insufficient balance");

        if(amount == 0 ){revert("Amount must be bigger than zero");}
        if(balance[msg.sender] < amount){revert("Insufficient balance");}

        uint oldBalance = balance[msg.sender];

        balance[msg.sender] -= amount;
        balance[to]+= amount;

        assert(balance[msg.sender] + balance[to] == oldBalance + balance[to]);
    }
}

contract error2{
    error InsufficientBalance(uint requested , uint available);

    function withdraw(uint amount) public {
        if(balance[msg.sender] < amount){
            revert InsufficientBalance(amount , balance[msg.sender]);
        }
        balance[msg.sender] -= amount ;
    }
}

contract Bank {
    mapping(address => uint) public balance;
    
    error InsufficientBalance(uint requested , uint available); 
    error InvalidAmount();
    
    event Deposit(address indexed user , uint amount);
    event withdraw (address indexed user , uint amount);

    function deposit() external payable {
        if (msg.value == 0 ){ revert InvalidAmount() ;}
        balance[msg.sender] += msg.value;
        emit Deposit(msg.sender , msg.value);
    }

    function withdraw(uint amount) external {
        if(amount == 0){
            revert InvalidAmount();
        }

        uint UserBalance = balance[msg.sender];


        if (userBalance>= amount) {
            revert InsufficientBalance(amount , userBalance);
        }
        balance[msg.sender] -= amount; //FİRSTLY STATE SHOULD CHANGE  
            payable(msg.sender).transfer(amount); //THEN İ CAN SENT MONEY else this is classical reentrancy error
            emit withdraw(msg.sender , amount);
            assert (balance[msg.sender] <= userBalance);
    }
}