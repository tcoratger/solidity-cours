// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

contract Basics {

    uint public y = 30;

    function ifelse(uint x) public view returns (uint) {
        if (x < 10) {
            return 0;
        } else if (x < 20) {
            return 1;
        } else {
            return 2;
        }
    }


    function ternary(uint x) public pure returns (uint) {
        return (x<10) ? 1 : 2;
    }

    function loop () public pure {
        for (uint i = 0; i < 10; i++) {
            if (i == 2) {

            } else {

            }
        }

        uint j;
        while (j< 10) {
            j++;
        }
    }





}