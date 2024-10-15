// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract lockedfund {
    address public owner;
    uint public timelimit = 30 days;

    mapping(address => uint) public lockedFunds;
    mapping(address => uint) public lockedTimeStamps;

    constructor() {
        owner = payable(msg.sender);
    }

    function lockFunds() public payable {
        require(msg.value > 0);
        require(lockedFunds[msg.sender] == 0);
        lockedFunds[msg.sender] = msg.value;
        lockedTimeStamps[msg.sender] = block.timestamp;
    }

    function releaseFunds() public {
        require(lockedFunds[msg.sender] > 0, "there is no fund to withdraw");
        require(block.timestamp >= lockedTimeStamps[msg.sender] + timelimit, "Please wait 1 month to withdraw");
        uint amount = lockedFunds[msg.sender];
        lockedFunds[msg.sender] = 0;
        lockedTimeStamps[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

}
