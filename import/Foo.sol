// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

struct TestStruct {
    uint x;
    uint y;
}

function addition(uint x, uint y) pure returns (uint) {
    return x + y;
}

contract Foo {
    string public nom = "Thomas";
}