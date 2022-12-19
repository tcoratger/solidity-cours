// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;


library Math {
    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }
}

contract TestMath {
    function testRacineCarree(uint x) public pure returns (uint) {
        return Math.sqrt(x);
    }
}

library MaLibrary {
    struct Joueur {
        uint score;
    }

    function incrementerScore(Joueur storage joueur, uint points) internal {
        joueur.score += points;
    }
}

contract TestLib {
    using MaLibrary for MaLibrary.Joueur;

    mapping(uint => MaLibrary.Joueur) players;

    function test() external {
        players[0].incrementerScore(14);
    }
}