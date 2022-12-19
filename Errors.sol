// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

contract Errors {

    // require
    // revert
    // assert

    function TestRequire(uint i) public pure{
        require(i > 10, "i doit etre superieur a 10");
    }

    function TestRevert(uint i) public pure {
        if (i <= 10) {
            revert("i doit etre superieur a 10");
        }
    }

    uint public num;

    function TestAssert() public view {
        assert(num == 0);
    }

    error FondsInsuffisants(uint fonds, uint qtteSouhaitee);

    function TestCustomError(uint qtte) public view {
        uint balance = address(this).balance;
        if (balance < qtte) {
            revert FondsInsuffisants({fonds: balance, qtteSouhaitee: qtte});
        }
    }

}