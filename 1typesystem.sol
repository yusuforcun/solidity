// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/* 
   TYPES LAB
   ---------
   This file contains the types for the system.
   Includes:
    - Value types: uint, int, bool, address, bytes1..32, enum
    - Reference types: bytes (dinamik), string, array, struct, mapping
    - storage / memory / calldata farkı
    - Type conversions (casting)
    - Default values
*/

contract TypeLabs {
    /* 1.  VALUE TYPES  */
    uint256 public u256 = 123 ;
    uint8 public u8 = 42 ;
    int256 public i256 = -5;
    int8 public i8 = -12;

    bool public flagTrue = true ;
    bool public flagFalse = false ;

    address public someAddress ;
    address payable public payableAddress ;

    bytes32 public hashValue ;
    bytes4 public selectorValue ;

    enum Status {None , Pending , Active , Closed}

    Status public currentStatus ;


    /* 2.  REFERENCE TYPES  */
    string public userName ;
    bytes public rawData ;

    uint256[3] public fixedArray  = [uint256(1) , 2 , 3 ];
    uint256[] public dynamicArray ;

    string[] public names ;

    struct User {
        uint256 id;
        address wallet ;
        string name ;
        bool isActive ;
    }

    User public exampleUser ;
    User[] public allUsers ;

    mapping(address => uint256) public balances ;
    mapping(address => User) public usersByAddress ;

    /* 3.  DEFAULT VALUES  */
    function getDefaultValues()
        external 
        view
        returns (
            uint256 defaultUint,
            int256 defaultInt,
            bool defaultBool,
            address defaultAddress,
            string memory defaultString,
            Status defaultStatus 
        )
        {
            defaultUint = u256 ;
            defaultInt = i256 ;
            defaultBool = flagFalse ;
            defaultAddress = someAddress ;
            defaultString = userName ;
            defaultStatus = currentStatus ;
        }

    /* 4.  TYPE CONVERSIONS  */
    function incrementLocalCopy(uint256 x) public pure returns (uint256){
        x = x + 1 ;
        return x ;
    }

    /* 5. REFERENCE TYPES */ 
    function pushToDynamicArray(uint256 value) external {
        dynamicArray.push(value) ;
    }

    function modifyArrayInMemory() external view returns (uint256[] memory){
        uint256[] memory temp = dynamicArray ;
        if (temp.length > 0) {
            temp[0] = 999 ;
        }
        return temp ;
    }

    function setExampleUser(
        uint256 _id ,
        address _wallet ,
        string calldata _name
    ) external {
        User storage u = exampleUser ;
        u.id  = _id ;
        u.wallet = _wallet ;
        u.name = _name ;
        u.isActive = true ;
    }

    function setNamesBatch(string[] calldata _names) external  {
        delete names ;
        for(uint256 i=0 ; i<_names.length ; i++) {
            names.push(_names[i]) ;
        }
    }


    /* STRING and BYTES */
    function setUserName(string calldata _name) external {
        userName = _name ;
    }

    function setRawData(bytes calldata _data) external {
        rawData = _data ;
    }

    function getNameLength() external view returns (uint256){
        return bytes(userName).length ;
    }


   /* ENUM */ 

   function getStatus (Status _status) external {
    currentStatus = _status ;
   }

   function activate() external {
    currentStatus = Status.Active ;
   }

   function close() external {
    require(currentStatus == Status.Active,"Only active status can be closed");
    currentStatus = Status.Closed;
   }

   /* MAPPİNG STRUCT ADDRESS */
   function deposit() external payable {
    balances[msg.sender] += msg.value ;
   }

   function getMyBalance() external view returns (uint256){
     return balances[msg.sender] ;
   }

   function registerUser(string calldata _name) external {
    User storage u = usersByAddress[msg.sender] ;
    require(u.id == 0, "User already registered");

    uint256 newId = allUsers.length + 1 ;

    u.id = newId ;
    u.wallet = msg.sender ;
    u.name = _name ;
    u.isActive = true ;

    allUsers.push(u) ;
   }
   /* TYPE CASTİNG*/
       function addressToUint(address _addr) external pure returns (uint256) {
        return uint256(uint160(_addr));
    }

    function getFirst4Bytes(bytes32 _data) external pure returns (bytes4) {
        return bytes4(_data);
    }

    function upcastUint8ToUint256(uint8 _x) external pure returns (uint256) {
        uint256 y = _x; // implicit cast
        return y;
    }

    function downcastUint256ToUint8(uint256 _x) external pure returns (uint8) {
        return uint8(_x);
    }

    /*ADDRESS PAYABLE*/
     function setPayableAddress(address payable _addr) external {
        payableAddress = _addr;
    }

    function sendEther(uint256 amount) external {
        require(address(this).balance >= amount, "Insufficient balance");

        (bool success, ) = payableAddress.call{value: amount}("");
        require(success, "ETH transfer failed");
    }


}

