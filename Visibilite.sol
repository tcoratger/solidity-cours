// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;


contract Visibilite {

    string public etatPublic = "public";
    string private etatPrivee = "privee";

    function fonctionPrivee() private pure returns (string memory) {
        return "fonction privee";
    }

    function fonctionPublique() public view returns (string memory) {
        return etatPrivee;
    }

    function fonctionExterne() external pure returns (string memory) {
        return "fonction externe";
    }
}