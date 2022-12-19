// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/token/ERC20/IERC20.sol
interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}


contract ERC20 is IERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name = "MonToken";
    string public symbol = "MT";
    uint8 public decimals = 18;


    function transfer(address recipient, uint amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}

contract swapcontract {

    // Token1 : adresse 1 contrat ERC20
    // Token2 : adresse 1 contrat ERC20
    // Swap(Token1, Token2)

    IERC20 public token1;
    address public owner1;
    uint public amount1;

    IERC20 public token2;
    address public owner2;
    uint public amount2;

    constructor(address _token1, address _owner1, uint _amount1,
    address _token2, address _owner2, uint _amount2) {

        token1 = IERC20(_token1);
        owner1 = _owner1;
        amount1 = _amount1;

        token2 = IERC20(_token2);
        owner2 = _owner2; 
        amount2 = _amount2;
    }

    function swap() public {

        // montant1 et montant2
        // token1: owner1 -> owner2 (montant1)
        // token2: owner2 -> owner1 (montant2)


        // personne qui appelle soit owner1 soit owner2
        // est ce que owner1 a donné le droit à ce smart contract de dépenser amount1
        // est ce que owner2 a donné le droit à ce smart contract de dépenser amount2

        // Transferfrom
            // token1: owner1 -> owner2 (montant1)
            // token2: owner2 -> owner1 (montant2)
        
        require(msg.sender == owner1 || msg.sender == owner2, "vous n'etes pas autorise");
        require(token1.allowance(owner1, address(this)) >= amount1, "le montant souhaite sur token1 est top eleve");
        require(token2.allowance(owner2, address(this)) >= amount2, "le montant souhaite sur token2 est top eleve");

        _safeTransaction(token1, owner1, owner2, amount1);
        _safeTransaction(token2, owner2, owner1, amount2);

    }

    function _safeTransaction(IERC20 token, address sender, address recipient, uint amount) private {

        bool Transact = token.transferFrom(sender, recipient, amount);
        require(Transact, "L'echange de token a echoue");

    }






}
