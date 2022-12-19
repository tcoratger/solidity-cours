// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

contract Transaction {

    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    function deposit() public payable {}

    function notPayable() public {}


    function transfer (address payable to, uint amount) public {
        (bool success, ) = to.call{value:amount}("");

        // to.transfer(amount);
        // to.send(amount);

        require(success, "Transaction echouee");
    }

}