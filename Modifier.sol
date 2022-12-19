// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

contract Modifier {

    address public owner;
    bool public ferme;

    constructor() {
        owner = msg.sender;
        ferme= false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "tu n'es pas le proprietaire");
        _;
    }

    modifier contractClosed() {
        require(!ferme, "le contrat est ferme");
        _;
    }

    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    function afficherMsg(string memory msg) public contractClosed returns (string memory) {
        return msg;
    }

    function fermerContrat() public onlyOwner {
        ferme = true;
    }

    // Déclarer une nouvelle variable d'état permettant de fermer le contrat ou non
    // Initialement cette variable est déclarée à false (le contrat est ouvert)
    // Si le contrat est ouvert alors je peux appeler une nouvelle fonction
        // Afficher "le contrat est ouvert"
    // Le Owner a le droit de fermer le contrat a tout moment en modifiant la variable de fermeture
        // Je n'ai plus le droit d'accéder à ma fonction



}