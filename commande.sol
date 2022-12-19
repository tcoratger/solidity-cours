// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

contract commande {

    address payable public vendeur;
    address payable public acheteur;

    uint public valeur;

    enum Etat {
        Created,
        Locked,
        Release,
        Inactive
    }

    Etat public etat;

    error ValeurImpaire();
    error uniquementAcheteur();
    error EtatIncorrect();

    event CommandeConfirmee();
    event CommandeRecue();

    // Vendeur va devoir deposer la moitie de la valeur du produit:
        // 4 ETH => 2 ETH
    
    constructor() payable {
        vendeur = payable(msg.sender);
        valeur = msg.value / 2;
        if ((2 * valeur) != msg.value)
            revert ValeurImpaire();
    }

    modifier UniquementAcheteur() {
        if (msg.sender != acheteur) {
            revert uniquementAcheteur();
        }
        _;
    }

    modifier inState(Etat _etat) {
        if (etat != _etat)
            revert EtatIncorrect();
        _;
    }


    function commandeConfirmee() external UniquementAcheteur payable {
        require(msg.value == 2 * valeur, "en tant qu'acheteur, tu n'as pas depose suffisamment");

        emit CommandeConfirmee();
        acheteur = payable(msg.sender);
        etat = Etat.Locked;
    }

    function commandeRecue() external UniquementAcheteur inState(Etat.Locked) {
        emit CommandeRecue();
        etat = Etat.Release;

        (bool sent, ) = acheteur.call{value: valeur}("");
        require(sent, "la transaction a l'acheteur a echoue");
    }

}