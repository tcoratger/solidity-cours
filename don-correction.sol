// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

contract don {


    // Donation structure
    struct Donation {
        uint id;
        uint amount;
        string donor;
        string message;
        uint timestamp; //seconds since unix start
    }

    // Useful variables
    uint amount = 0;
    uint id = 0;

    // Mapping structures
    mapping(address => uint) public balances;
    mapping(address => Donation[]) public donationsMap;

    event DonationEvent(
        uint id,
        uint amount,
        string donor,
        string message
    );

    // Donate function associated with a recipient address
    function donate(address _recipient, string memory _donor, string memory _msg) public payable {
        require(msg.value > 0, "The donation needs to be >0 in order for it to go through");
        amount = msg.value;
        balances[_recipient] += amount;        
        donationsMap[_recipient].push(Donation(id++, amount, _donor, _msg, block.timestamp));
    }

    // Withdraw your funds
    function withdraw() public {  // whole thing by default.
        amount = balances[msg.sender];
        balances[msg.sender] -= amount;
        require(amount > 0, "Your current balance is 0");
        (bool success,) = msg.sender.call{value:amount}("");
        if (!success) {
            revert();
        }
    }

    function donations_getter(address _recipient) public view returns (Donation[] memory){
        return donationsMap[_recipient];
    } 
  
    // Require the balance of a getter
    function balances_getter(address _recipient) public view returns (uint){
            return balances[_recipient];
    }
    
    // Get balance of the sender
    function getBalance() public view returns(uint) {
            return msg.sender.balance;
    }


}