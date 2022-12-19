// SPDX-License-Identifier: GPL-3.0



// Signifie que le code est compatible avec n'importe quelle version du compilateur de Solidity 0.7.0 à 0.8.9.

pragma solidity >=0.7.0 <0.9.0;




// Import du contrat OpenZeppelin ERC20 dans le fichier.

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";



// Initialisation du Token, héritant du contrat ERC20.sol :



/*Déclaration contrat "DevToken", avec mot-clé Solidity contract , héritage ERC20 OpenZeppelin avec mot-clé "is".



L'héritage du contrat ERC20 nous donnera accès à des méthodes comme _mint() et balanceOf().*/





contract DevToken is ERC20{

    // Création crypto-monnaie en appelant le constructeur du contrat et en fournissant le nom et le symbole du jeton.

    constructor() ERC20("DevToken", "DVT"){}

    function _mint(address account, uint256 amount) internal virtual {

        require(account != address(0), "ERC20: mint to the zero address");



        _beforeTokenTransfer(address(0), account, amount);



        totalSupply += amount;

    
        emit Transfer(address(0), account, amount);



        _afterTokenTransfer(address(0), account, amount);

    }

}