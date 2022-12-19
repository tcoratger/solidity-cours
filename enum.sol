// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

contract Enum {

    enum Statuts {
        Accepte, // 0
        EnAttente, // 1
        Envoye, // 2
        Rejete, // 3
        Annule // 4
    }


    Statuts public statuts;


    function get() public view returns(Statuts) {
        return statuts;
    }

    function selectionStatut(Statuts _statut) public {
        statuts = _statut;
    }

    function annule() public {
        statuts = Statuts.Annule;
    }

    function reset() public {
        delete statuts;
    }


}