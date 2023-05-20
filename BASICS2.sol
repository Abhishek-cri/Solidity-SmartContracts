// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract Inheritance {
    address owner;
    bool deceased;
    uint money;

    constructor() payable {
        owner = msg.sender;
        money = msg.value;
        deceased = false;
    }

    modifier Oneowner() {
        require(msg.sender == owner);
        _;
    }

    modifier isDeceased() {
        require(deceased == true);
        _;
    }

    address payable[] wallets;
    uint[] inheritances;

    mapping(address => uint) inheritance;

    function setup(address payable _wallet, uint _inheritance) public Oneowner {
        wallets.push(_wallet);
        // inheritances.push(_inheritance);
        inheritance[_wallet] = _inheritance;
    }

    function moneypaid() public isDeceased {
        for (uint i = 0; i < wallets.length; i++) {
            wallets[i].transfer(inheritance[wallets[i]]);
        }
    }

    function died() public Oneowner {

        deceased=true;
        moneypaid();

    }
}
