# Susu by Absa Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.



Susu Smart Contract

Introduction

This smart contract, named "SusuContract," is designed to facilitate group savings and disbursement activities. It allows users to join a savings pool, make daily deposits, and receive disbursements at specific intervals. The contract is structured to provide transparency and automation for savings and disbursement processes.

Functions

1. `joinSusu()`

- Description: Allows users to join the Susu savings pool.
- Requirements:  Users must not be the contract owner and should not already be a member.
- Usage:  Members are added to the `members` list with a balance of 0.

2. `makeDeposit()`

- Description:  Allows members to make daily deposits to their savings.
- Requirements: Deposits are not allowed during disbursement, and members can only deposit once a day.
- Usage: Members can deposit 50 cedis daily. After three days of inactivity, a member is removed from the pool.

3. `disburseFunds()`

- Description:  Initiates the quarterly disbursement of pooled funds.
- Requirements: Only the contract owner can initiate disbursement, and it must be time for disbursement.
- Usage: Pooled funds are split equally among all members, and the next distribution date is reset.

4. `disburseToOnePerson()`

- Description: Initiates the monthly disbursement of pooled funds to one member.
- Requirements: Only the contract owner can initiate disbursement, and it must be time for disbursement.
- Usage: Pooled funds are split with one member, and the other half is sent for investment. The rotation mechanism ensures that every member has a turn to receive funds.


5. `getLastDepositTime()`

- Description: Returns the timestamp of the last deposit made by the caller.
- Usage: Members can check the timestamp of their last deposit.

6. `getMyBalance()`

- Description:  Returns the balance of the current user.
- Usage:  Members can check their current savings balance.




# SuSuByAbsa
