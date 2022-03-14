// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../contracts/PiToken.sol";
import "truffle/Assert.sol";


contract TestPiToken {
    function testNameNewToken() public {
        PiToken piToken = new PiToken(100000000000000000000);
        Assert.equal(piToken.name(), "PiToken", "Wrong name");
    }

    function testInitialSupply() public {
        uint256 initialSupply = 314;
        PiToken piToken = new PiToken(initialSupply);
        address myAddress = address(this);
        uint256 balanceStart = piToken.balanceOf(myAddress);
        Assert.equal(balanceStart, initialSupply, "Initial supply of token was not granted");
    }

    function test2DecimalsPi() public {
        PiToken piToken = new PiToken(100000000000000000000);
        address myAddress = address(this);
        string memory guess = "3.14";
        string memory res = piToken.iKnowMyPi(myAddress, guess);
        Assert.equal(res, "Pi-tastic. You have recieved your reward.", "Pi guess was correct, but not recognized as such.");
    }

    function test2DecimalsPiReward() public {
        uint256 initialSupply = 100000000000000000000;
        PiToken piToken = new PiToken(initialSupply);
        address myAddress = address(this);
        uint256 balanceStart = piToken.balanceOf(myAddress);
        string memory guess = "3.14";
        piToken.iKnowMyPi(myAddress, guess);
        uint256 balanceEnd = piToken.balanceOf(myAddress);
        Assert.equal(balanceEnd, balanceStart + 2 * 314, "This guess should have given 2x314 PiToken as a reward");
    }

    function test10DecimalsPiReward() public {
        uint256 initialSupply = 100000000000000000000;
        PiToken piToken = new PiToken(initialSupply);
        address myAddress = address(this);
        uint256 balanceStart = piToken.balanceOf(myAddress);
        string memory guess = "3.1415926535";
        piToken.iKnowMyPi(myAddress, guess);
        uint256 balanceEnd = piToken.balanceOf(myAddress);
        Assert.equal(balanceEnd, balanceStart + 10 * 314, "This guess should have given 10x314 PiToken as a reward");
    }

    function testMoreDecimalsPi() public {
        PiToken piToken = new PiToken(100000000000000000000);
        address myAddress = address(this);
        string memory guess = "3.141592653589793238462643383279502884197169399375105820";
        string memory res = piToken.iKnowMyPi(myAddress, guess);
        Assert.equal(res, "Pi-tastic. You have recieved your reward.", "Pi guess was correct, but not recognized as such.");
    }

    function testWrongPi() public {
        PiToken piToken = new PiToken(100000000000000000000);
        address myAddress = address(this);
        string memory guess = "3.15";
        string memory res = piToken.iKnowMyPi(myAddress, guess);
        Assert.equal(res, "Mwep... that was wrong, can't reward you with some pi", "Pi guess was correct, but not recognized as such.");
    }

    function testWrongStart() public {
        PiToken piToken = new PiToken(100000000000000000000);
        address myAddress = address(this);
        string memory guess = "3.41592653589793238462643383279502884197169399375105820";
        string memory res = piToken.iKnowMyPi(myAddress, guess);
        Assert.equal(res, "Mwep... that was wrong, can't reward you with some pi", "Pi guess was correct, but not recognized as such.");
    }
}