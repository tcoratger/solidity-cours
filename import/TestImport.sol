// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

import "./Foo.sol";
import {addition as func, Foo} from "./Foo.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol";



contract TestImport {
    Foo public testFoo = new Foo();

    function getName() public view returns (string memory) {
        return testFoo.nom();
    }
}