//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*Data Locations*/

contract DataLocationsLab {
    /*  1. STATE (STORAGE)*/
    uint256[] public numbers ;
    string public globalMessage ;
    struct User {
        uint256 id ;
        string name ;
    }
    User public storedUser ;

    /* 2. work with storage */
    function pushNumber(uint256 x) external {
        numbers.push(x);
    }

    function setStoredUser(uint256 _id , string calldata _name) external {
        User storage u = storedUser ;
        u.id = _id ;
        u.name = _name ;   
    }

    /*  3. MEMORY  */
    function getNumbersWithFirstChanged()
        external
        view
        returns(uint256[] memory)
    {
        uint256[] memory temp = numbers ;
        if (temp.length > 0){
            temp[0] = 999 ;
            return temp;
        }
    }
    
    function shoutMessage()
        external
        view
        returns(string memory)
        {
            string memory msgCopy = globalMessage ;
            return string (abi.encodePacked(msgCopy,"!!!"));
        }

    
    /* 4.CALLDATA */
    function sumCalldataArray (uint256[] calldata arr)
        external 
        pure 
        returns(uint256)
        {
            uint256 s ;
            for (uint256 i = 0 ; i < arr.length ; i++) {
                s += arr[i] ;
            }
            return s ;
        }
    
    function setGlobalMessage (string calldata newMessage) external {
        globalMessage = newMessage ;
    }

    function overwriteNumbers(uint256[] calldata newNumbers) external {
        delete numbers ;
        for (uint256 i=0 ; i<newNumbers.length ; i++){
            numbers.push(newNumbers[i]);
        }
    }

    /* 5. storage vs memory vs calldata*/
    function setFirstNumberStorage(uint256 newValue) external {
        require(numbers.length > 0 , "empty");
        numbers[0] = newValue ;
    }

    function getFirstNumberChangedInMemory(uint256 newValue) 
    external
    view
    returns(uint256[] memory)
    {
        uint256[] memory  temp = numbers ;
        if (temp.length > 0 ){
            temp[0] = newValue ;
        }
        return temp ;
    }

    function isFirstEqualTo(uint256[] calldata arr , uint256 x) 
    external
    view
    returns(bool)
    {
        if(arr.length == 0 ) return false ;
        return arr [0] == x ;
    }
}