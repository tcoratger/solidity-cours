// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

contract Units {
    uint public oneWei = 1 wei;
    bool public isOneWei = 1 wei == 1;


    uint public oneEther = 1 ether;
    bool public isOneEther = 1 ether == 1e18;

}