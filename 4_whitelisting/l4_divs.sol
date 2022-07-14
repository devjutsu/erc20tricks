// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Dividents is Ownable {
    ERC20 public token;
    uint256 public divDate;
    uint256 public divSumm;
    uint256 public totalRegistredAmount;

    mapping(address => uint256) public Reestr;

    constructor(ERC20 _token) {
        token = _token;
    }

    function setDivDate(uint256 _unixdate) public onlyOwner {
        divDate = _unixdate;
    }

    function setDivSumm() public payable onlyOwner {
        divSumm = msg.value;
    }

    function registration(uint256 _amount) external {
        require(divSumm > 0, "To early!");
        require(block.timestamp < divDate, "To late!");
        token.transferFrom(msg.sender, address(this), _amount);
        totalRegistredAmount+=_amount;
        Reestr[msg.sender] = _amount;
        emit tokensRegistred(msg.sender, _amount);
    }

    function withdrow() external {
        require(block.timestamp > divDate, "To early!");
        require(Reestr[msg.sender] > 0, "Nothing to pay!");

        uint256 amount = Reestr[msg.sender];
        uint256 divs = (divSumm * amount) / totalRegistredAmount;

        Reestr[msg.sender] = 0;

        token.transfer(msg.sender, amount);
        (bool success, ) = payable(msg.sender).call{value: divs}("");
        require(success);

        emit divsPayed(msg.sender, Reestr[msg.sender]);
    }

    event tokensRegistred(address owner, uint256 value);
    event divsPayed(address owner, uint256 value);
}