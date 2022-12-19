// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

contract A {

    function testTuple() public pure returns(uint, string memory) {
        return (1, "test message");
    }

    function callTuple() public pure returns(uint) {
        uint a;
        (a,) = testTuple();
        return a;
    }
}

contract tableau {
    string[] stringArray;

    function test() public {
        stringArray.push("test message 1");
        stringArray.push("test message 2");
    }


    function getArray(uint index) public view returns(string memory) {
        return stringArray[index];
    }
}