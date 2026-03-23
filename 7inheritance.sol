// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Test {
    address public owner ;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner , "not owner");
        _;
    }

    function withdraw() public onlyowner {

    }
}

contract OwnableE {
    address public owner ;

    constructor (){
        owner = msg.sender ;
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"not owner");
        _;
    }
}

contract Mycontract is OwnableE {
    function withdraw() public onlyOwner {

    }
}


contract Ownable {
    address public owner ;

    constructor(){
        owner = msg.sender ;
    }

    modifier onlyOwner(){
        require(msg.sender == owner , "Only use owner");
        _;
    }
}

contract Pausable is Ownable{
    bool public paused ;

    modifier whenNotPaused(){
        require(!paused, "paused");
        _;
    }

    function pause() externel onlyOwner {
        paused = true ;
    }

    function unpause() external onlyOwner{
        paused = false ;
    }
}

contract Vault is Pausable{
    mapping(address => uint) public balances;

    function deposit () external payable whenNotPaused {
        balances[msg.sender] += msg.value ;
    }

    function withdrawMyMoney(uint amount) external onlyOwner whenNotPaused{
            require(address(this).balance >=amount,"Not Enough");

        balances [msg.sender] -= amount ;

        payable(msg.sender).transfer(amount);
    }


    function withdraw(uint amount) external onlyOwner whenNotPaused {
        require(address(this).balance >=amount,"Not Enough");

        balances [msg.sender] -= amount ;

        payable(msg.sender).transfer(amount);
    }
}