// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.13 and less than 0.9.0
pragma solidity ^0.8.13;


contract encode {

    function EncoreSignature(address to, uint montant) external pure returns (bytes memory) {

        return abi.encodeWithSignature("transfer(address, uint256)", to, montant);
    }
}

contract array {
    uint[] public arr;


    // function remove(uint index) {
     //   arr[index] = arr[arr.length - 1];
     //   arr.pop();
    //}

    function test() external {
        arr = [1, 2, 3, 4, 5];
        // remove(2);
        delete arr[2];
        //[1, 2, 4, 5]

        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);
    }
}