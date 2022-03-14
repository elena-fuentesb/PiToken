// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/token/ERC20/extensions/ERC20Capped.sol";

contract PiToken is ERC20Capped {
    mapping (address => uint) balances;

    constructor(uint256 initialSupply) ERC20("PiToken", "PI") ERC20Capped(314*10**18){
        ERC20._mint(msg.sender, initialSupply);
    }

    function containsFromStart(string memory what, string memory where) pure internal returns (bool, uint index)  {
        bytes memory whatBytes = bytes (what);
        bytes memory whereBytes = bytes (where);

        require(whereBytes.length >= whatBytes.length);

        bool found = true;
        uint j = 0;
        for (j = 0; j < whatBytes.length; j++) {
            if (whereBytes [j] != whatBytes [j]) {
                found = false;
                break;
            }
        }
        return (found, j);
    }

    function iKnowMyPi(address account, string memory piDecimals) public returns(string memory) {
        string memory first100Decimals = "3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679";
        (bool contains, uint index) = containsFromStart(piDecimals, first100Decimals);
        if(contains && index >= 2) {
            issueToken(account, index - 2);
            return "Pi-tastic. You have recieved your reward.";
        } else {
            return "Mwep... that was wrong, can't reward you with some pi";
        }
    }

    function issueToken(address account, uint256 nrOfDecimals) internal {
        mint(account, 314 * nrOfDecimals);
    }

    function mint(address beneficiary, uint256 mintAmount) internal {
        _mint(beneficiary, mintAmount);
    }
}