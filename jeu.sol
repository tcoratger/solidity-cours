// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

contract jeu {

    // cible-target (10 Ether) = montant à obtenir pour gagner le jeu
    // address d'un gagnant

    // deposer argent
        // 1 ETHER par 1 ETHER
        // Vérifier si le montant déposé est inférieur ou non à la cible
        // Si montant = cible alors sender = vainqueur

        // Vainqueur peut alors récupérer tout l'argent

    // vérification: fonction qui me donne le balance de mon contrat => 1 ETHER / 3 ETHER / 


    uint public targetAmount = 5 ether;
    address public gagnant;
    uint public balance;

    // Thomas 1 => 1 
    // Léo 1 => 2
    // Théo 1 => 3 
    // Léa 1 => 4
    // Clara 1 => 5

    // gagnant = Clara 

    function deposit() public payable {

        // Vérifier que le dépôt est bien égal à 1 ETHER
        // Incrémenter le balance
        // Comparer le balance par rapport à target
            // Si balance > target alors transaction refusée
            // Update gagnant
        
        require(msg.value == 1 ether, "attention uniquement 1 ether");
        balance += msg.value;

        require(balance <= targetAmount, "jeu termine");

        if (balance == targetAmount) {
            gagnant = msg.sender;
        }
    }

    function ObtenirGain() public {

        require(msg.sender == gagnant, "tu n'es pas le gagnant");

        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Transaction refusee");

    }



    function getBalance() public view returns (uint) {
        //return address(this).balance;
        return balance;
    }





}