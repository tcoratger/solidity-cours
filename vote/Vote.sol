// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;


contract Vote {

    // Structure: obtenir toutes les informations relatives aux votants
    struct Voter {
        uint poidsVotant; // Mon vote seul = 1; 2 votes délégués = 2....
        bool voted; // true si a déjà voté et false si pas de vote
        address delegue; // Adresse de la personne à qui on souhaite déléguer le vote
        uint vote; // propositions
    }

    // Définition d'une proposition
    struct Proposition {
        bytes nom; // Nom de ma proposition
        uint compteVote; // Nombre de vote pour cette proposition
    }

    address public responsable;

    // Récapitulatifs des votants avec les informations nécessaires
    mapping(address => Voter) public votants; 

    // Tableau de toutes mes propositions
    Proposition[] public propositions;

    constructor(string[] memory nomPropositions) {
        responsable = msg.sender;
        votants[responsable].poidsVotant = 1;

        for (uint i=0; i< nomPropositions.length; i++) {
            propositions.push(
                Proposition({
                nom: bytes(nomPropositions[i]),
                compteVote: 0
                })
            );
        }
    }

    // Donner le droit de vote
    function donnerDroitVote(address votant) external {
        require(msg.sender == responsable, "tu n'es pas le responsable");
        require(!votants[votant].voted, "l'adresse indiquee a deja vote");
        require(votants[votant].poidsVotant == 0, "l'adresse indiquee a deja recu un ou plusieurs droits de vote");

        votants[votant].poidsVotant = 1;
    }


    function deleguerDroitVote(address to) external {
        Voter storage from = votants[msg.sender];
        require(from.poidsVotant > 0, "tu n'as pas le droit de vote");
        require(!from.voted, "tu as deja vote");
        require(to != msg.sender, "l'auto-delegation est interdite");

        while (votants[to].delegue != address(0)) {
            to = votants[to].delegue;
            require(to != msg.sender, "l'auto-delegation est interdite");
        }

        from.voted = true;
        from.delegue = to;
        Voter storage _delegue = votants[to];

        //require(!_delegue.voted, "la personne a qui tu souhaites deleguer ton vote a deja vote");

        if (_delegue.voted) {
            propositions[_delegue.vote].compteVote += from.poidsVotant;
        } else {
            _delegue.poidsVotant += from.poidsVotant;
        }
    }

    function vote(uint proposition) external { // 0 1 2

        Voter storage from = votants[msg.sender];

        require(from.poidsVotant != 0, "tu n'as pas le droit de vote");
        require(!from.voted, "tu as deja vote");
        require(proposition < propositions.length, "la proposition mentionnee n'existe pas");

        from.voted = true;
        from.vote = proposition;

        propositions[proposition].compteVote += from.poidsVotant;

    }


    function PropositionGagnante() public view returns (uint _propositionGagnante) {
        uint compteV;
        for (uint i = 0; i<propositions.length; i++) {
            if (propositions[i].compteVote > compteV) {
                compteV = propositions[i].compteVote;
                _propositionGagnante = i;
            }
        }
        return _propositionGagnante;
    }

    function getNomPropositionGagnante() external view returns (string memory _propositionGagnante) {
        return string(propositions[PropositionGagnante()].nom);
    }
}