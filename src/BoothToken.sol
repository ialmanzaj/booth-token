// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract BoothToken is ERC20Capped, ERC20Burnable  {
    address payable public owner;
    uint public blockReward;

    constructor(uint cap, uint reward) ERC20("BoothToken", "BOOTH") ERC20Capped(cap * (10 ** decimals())) {
        owner = payable(msg.sender);
        uint exponential = 10 ** decimals();
        _mint(msg.sender, 7000000 * exponential);
        blockReward = reward * exponential;
    }

    function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(address from, address to, uint amount) internal virtual override {
        if (from != address(0) && to != block.coinbase && block.coinbase != address(0)) {
            _mintMinerReward();
        }
        super._beforeTokenTransfer(from, to, amount);
    }
    function destroy() public onlyOwner {
        selfdestruct(owner);
    }

    function setBlockReward(uint reward) public onlyOwner {
        blockReward = reward * (10 ** decimals());
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    /**
     * @dev See {ERC20-_mint}.
     */
    function _mint(address account, uint amount) internal virtual override(ERC20, ERC20Capped)  {
        super._mint(account, amount);
    }

}
