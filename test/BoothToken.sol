// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/BoothToken.sol";
import "forge-std/console.sol";

contract BoothTokenTest is Test {
    BoothToken public token;
    address public owner;
    address bob = address(0x1);
    uint256 total_market_cap = 1000000000;
    uint256 tokenBlockReward = 50;
    uint exponential = 10 ** 18;
    uint owner_supply = 7000000;
    uint owner_total_supply = owner_supply * exponential;

    function setUp() public {
        vm.startPrank(bob);
        token = new BoothToken(total_market_cap, tokenBlockReward);
    }

    function testSetRightOwner() public {
        assertEq(token.owner(), bob);
    }

    function testTotalBalanceSupply() public {
        uint256 ownerBalance = token.balanceOf(bob);
        assertEq(ownerBalance, owner_total_supply);
        assertEq(token.cap(), total_market_cap * exponential);
    }
}
