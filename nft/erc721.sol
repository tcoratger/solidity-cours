// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

contract ERC721 {

    // id (uint) => address

    // Mint => créer un token (to (address), id (uint))
        // Secu: pas de mint sur adresse 0
        // Id unique
        // Evenement
    
    // Burn (id) => owner

    // Owner(id) => owner

    event Transfert(address indexed from, address indexed to, uint indexed id);
    event Approval(address indexed proprietaire, address indexed to, uint indexed id);

    mapping(uint => address) public proprietaires;
    mapping(address => uint) public nbrTokens;
    mapping(uint => address) public approvals;

    function mint(address to, uint id) public {
        require(to != address(0), "il est interdit de faire un mint sur l'adresse 0");
        require(proprietaires[id] == address(0), "ce nft existe deja");

        nbrTokens[to]++;
        proprietaires[id] = to;

        emit Transfert(address(0), to, id);
    }

    function burn(uint id) public {
        address proprietaire = proprietaires[id];
        require(proprietaire != address(0), "ce token n'a pas encore ete cree");
        require(msg.sender == proprietaire, "tu n'es pas le proprietaire de ce token");

        nbrTokens[proprietaire]--;

        delete proprietaires[id];

        emit Transfert(proprietaire, address(0), id);

    }

    function transfert(address to, uint id) public {
        address proprietaire = proprietaires[id];
        require(proprietaire != address(0), "ce token n'a pas encore ete cree");
        require(msg.sender == proprietaire, "tu n'es pas le proprietaire de ce token");

        nbrTokens[proprietaire]--;
        nbrTokens[to]++;

        proprietaires[id] = to;

        emit Transfert(proprietaire, to, id);
    }

    function approve(address destinataire, uint id) public {
        address proprietaire = proprietaires[id];
        require(proprietaire != address(0), "ce token n'a pas encore ete cree");
        require(msg.sender == proprietaire, "tu n'es pas le proprietaire du token, tu n'as donc pas les droits pour realiser cette action");

        approvals[id] = destinataire;
        emit Approval(proprietaire, destinataire, id);
    }

    function approveFromApprovals(address destinataire, uint id) public {
        // Vérifier que je suis soit le proprietaire soit une personne approuvée pour ce token
        // Mettre à jour mapping approbation
        address proprietaire = proprietaires[id];
        address approuve = approvals[id];

        require(proprietaire != address(0), "ce token n'a pas encore ete cree");
        require(approuve != address(0), "aucune approbation n'a encore ete realisee");
        require(msg.sender == approuve, "aucune approbation ne t'a ete donne pour ce token");

        approvals[id] = destinataire;
        emit Approval(approuve, destinataire, id);

    }

    function transfertFrom(address to, uint id) public {

        address proprietaire = proprietaires[id];
        address approuve = approvals[id];

        require(proprietaire != address(0), "ce token n'a pas encore ete cree");
        require(msg.sender == proprietaire || msg.sender == approuve, "tu n'as pas le droit d'appeler cette fonction");
        require(msg.sender != address(0), "tu n'as pas le droit de realiser une transaction depuis l'addresse 0");
        require(msg.sender != to, "tu n'as pas le droit de transfert le token au proprietaire");

        nbrTokens[proprietaire]--;
        nbrTokens[to]++;

        proprietaires[id] = to;

        delete approvals[id];

        emit Transfert(msg.sender, to, id);

    }

}