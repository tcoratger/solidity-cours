// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

contract don {

    uint id=0;
    uint amount=0;

    struct Don {
        uint id;
        uint montant;
        string donateur;
        string message;
    }

    mapping(address => uint) public balance;
    mapping(address => Don[]) public donMap;

    //balance: 
        //address1 => 10
        //address2 => 34
        //address3 => 1
    
    //donMap:
        //address1 => Don(id, montant, donateur, message)
        //address2 => Don(id, montant, donateur, message)
        //address3 => Don(id, montant, donateur, message)


    // 1 Get balance de la personne qui dépose


    // 2 Déposer
    function donner(address _to, string memory _donateur, string memory _msg) public payable {

        // Dépôt > 0
        // Capturer dépôt
        // dépot pour adresse du donateur incrémenter (balance)
        // Incrémeneter donMap avec toutes les informations que j'ai

        require(msg.value > 0, "le depot est nul");

        amount = msg.value;
        balance[_to] += amount;
        donMap[_to].push(Don(id++, amount, _donateur, _msg));
    }


    function withdraw() public {
        amount = balance[msg.sender];
        balance[msg.sender] -= amount;
        require(amount >0, "votre balance est 0");
        (bool success,) = msg.sender.call{value:amount}("");
        require(success, "la transaction a echoue");
    }


    function getdonMap(address addr) public view returns (Don[] memory) {
        return donMap[addr];
    }

    function getbalanceMap(address addr) public view returns (uint) {
        return balance[addr];
    }

    function getBalanceUser() public view returns (uint) {
        return msg.sender.balance;
    }



}