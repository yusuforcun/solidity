// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ReceiveFallbackExample {
    event Received(address sender , uint amount);
    event FallbackCalled(address sender , uint amount , bytes data);

    receive() external payable {
        emit Received(msg.sender , msg.value);
    }

    fallback() external payable {
        emit FallbackCalled(msg.sender,msg.value,msg.data);
    }
    
}

contract Challangence {

    event fallbacklog(address sender , uint amount , bytes data);

    receive() external payable{
        require(msg.value > 1 ether , "Minimum 1 ETH ");
    }

    fallback() external payable{
        require(msg.value == 0 , "Non expected with fallback");
        emit fallbacklog(msg.sender, msg.value ,msg.data);
    }
}

contract ChallangenceTwo {

    event trapped(address user );

    mapping(address => uint) public balances;
    mapping(address => bool) public blacklisted;

    receive() external payable {
        require(!blacklisted[msg.sender],"Blacklisted");
        require(msg.value <=  5 ether && msg.value >= 0.5 ether,"Only this arrange");
        balances[msg.sender] += msg.value ;
    }

    fallback() external payable {
        require(msg.value == 0 ,"Fallback isnt accept the eth");

        blacklisted[msg.sender] = true ;
        emit trapped(msg.sender);
    }

    function withdraw (address adress,uint amount){
        require(!blacklisted[msg.sender] , "Blacklisted");
        require(balances[msg.sender] >= amount , "insufficient balance");

        balances[msg.sender] -= amount ;

        (bool success , ) = msg.sender.call{value : amount}("");
        require(success , "Transfer failed");
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}