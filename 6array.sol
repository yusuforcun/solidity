// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract array {
    uint[] public arr ;

    function set(uint[] calldata _arr) external {
        arr = _arr ;
    }


    function del(uint[] calldata i) external {
    delete arr[i];
    arr[i] = arr[arr.length - 1];
    arr.pop();
    }

    uint[] arr;
    mapping(uint => uint) indexOf ;

}