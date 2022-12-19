// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;

contract Mapping {

    mapping (address => uint) public monmap;

    // Address => uint
    // Address + uint 
        // Somme

    function set(address _addr, uint _i) public {
        // Update the value at this address
        monmap[_addr] = monmap[_addr] + _i;
    }

    function get(address _addr) public view returns (uint) {
        // Mapping always returns a value.
        // If the value was never set, it will return the default value.
        return monmap[_addr];
    }


}