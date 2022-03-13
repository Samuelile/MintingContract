// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract MintingContract {

    string public name;
    mapping(address => uint) public balances;

    constructor(string memory _name) {

        name = _name;
    }

    function mint() virtual public {

        balances[tx.origin]++;
    }
}

contract MintingWithOwnersContract is MintingContract {

    string public symbol;
    uint ownerCount;
    address[] public owners;

    constructor(string memory _name, string memory _symbol)
    MintingContract(_name) {
        symbol = _symbol;
    }
    function mint() override public {

        super.mint();

        ownerCount ++;

        owners.push(msg.sender);
    }
}

contract someOtherContract {
    MintingWithOwnersContract public m = new MintingWithOwnersContract("myName", "MNS");
    MintingContract public a = new MintingWithOwnersContract("myName", "MNS");
    MintingContract public b = new MintingContract("myName");
}
