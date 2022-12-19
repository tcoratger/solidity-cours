// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

contract FirstTest {

    string public str = "test";
    uint public num = 326;

    uint public time;
    address public addr_sender;

    function test() public {
        uint loc = 34;

        uint timestamp = block.timestamp;
        address sender = msg.sender;

        time = timestamp;
        addr_sender = sender;

    }


}