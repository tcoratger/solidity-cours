// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;


contract A {
    function testA() public pure virtual returns (string memory) {
        return "contrat A";
    }
}

contract B is A {

    function testA() public pure virtual override returns (string memory) {
        return "contrat B";
    }
}

contract C is A {
    function testA() public pure virtual override returns (string memory) {
        return "contrat C";
    }
}

contract D is B,C {
    function testA() public pure override(B,C) returns (string memory) {

        return super.testA();

    }
}


contract E is C,B {
    function testA() public pure override(C,B) returns (string memory) {
        return super.testA();
    }
}



