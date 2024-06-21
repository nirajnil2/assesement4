// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Assessment {
    // State variables
    address payable public owner;
    uint256 public balance;

    // Events
    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);

    // Custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    // Constructor to initialize the contract
    constructor(uint256 initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    // Public view function to get the balance
    function getBalance() public view returns (uint256) {
        return balance;
    }

    // Public function to deposit funds into the contract
    function deposit(uint256 _amount) public payable onlyOwner {
        uint256 _previousBalance = balance;
        balance += _amount;

        // Ensure the transaction is completed successfully
        assert(balance == _previousBalance + _amount);

        emit Deposit(_amount);
    }

    // Public function to withdraw funds from the contract
    function withdraw(uint256 _withdrawAmount) public onlyOwner {
        uint256 _previousBalance = balance;
        
        // Check for sufficient balance
        if (balance < _withdrawAmount) {
            revert InsufficientBalance(balance, _withdrawAmount);
        }

        balance -= _withdrawAmount;

        // Ensure the transaction is completed successfully
        assert(balance == _previousBalance - _withdrawAmount);

        emit Withdraw(_withdrawAmount);
    }

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner of this account");
        _;
    }
}

