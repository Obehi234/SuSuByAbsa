// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18; 

// Define the state variables
contract SusuContract {
    address public owner;  // Address of the contract owner
    address[] public members;  // Addresses of all members
    mapping(address => uint256) public balances;  // Member balances
    mapping(address => uint256) public lastDepositTimestamp;
    uint256 public nextDistributionDate;  // Next distribution date
    uint256 public endOfMonthDistributionDate;  // End of Month distribution date
    uint256 public lastMember = 0;
    uint256 public poolAmount = 0;
    bool public disbursing;  // Flag to control disbursement

    // Events to log contract activities
    event Deposit(address indexed member, uint256 amount);
    event Disbursed(uint256 totalAmount);

    // Constructor to initialize the contract
    constructor() {
        owner = msg.sender;
        nextDistributionDate = block.timestamp + 360 days;  // Yearly distribution
        endOfMonthDistributionDate = block.timestamp + 30 days; // Monthly distribution
    }

    // Modifier to ensure that only members can perform certain actions
    modifier onlyMember() {
        require(balances[msg.sender] >= 0, "You are not a member.");
        _;
    }

    // Function to join the Susu pool
    function joinSusu() public {
        require(msg.sender != owner, "The contract owner cannot join.");
        require(balances[msg.sender] == 0, "You are already a member.");
        // require( /* Add logic to check for Absa account here */, "Absa account is required.");


        balances[msg.sender] = 0;
        members.push(msg.sender);
    }

    // Function to make daily deposits
    function makeDeposit() public onlyMember {
        require(!disbursing, "Deposits are not allowed during disbursement.");
        
        address currentUser = msg.sender;
        
        // Check if the user has made a deposit within the last 24 hours
        require(block.timestamp - lastDepositTimestamp[currentUser] >= 1 days, "You can only deposit once a day.");

          // Check if the user has made a deposit before
    if (lastDepositTimestamp[msg.sender] == 0) {
        // This is the user's first deposit, so there's no time limit
        // Perform the deposit logic
        // ...


        // Update the user's balance and last deposit timestamp

        balances[msg.sender] += 50;
        lastDepositTimestamp[msg.sender] = block.timestamp;
        emit Deposit(msg.sender, 50);
    } else {
        // Calculate the timestamp for 3 days ago
        uint256 threeDaysAgo = block.timestamp - (3 * 1 days);

        // Check if the last deposit was made within the last 3 days
        require(lastDepositTimestamp[msg.sender] >= threeDaysAgo, "Last deposit exceeded 3 days ago");

        // Update member's balance
        balances[msg.sender] += 50;
        lastDepositTimestamp[msg.sender] = block.timestamp;
        emit Deposit(msg.sender, 50);
    }
    }

    // Function to disburse funds (Yearly)
    function disburseFunds() public {
        require(msg.sender == owner, "Only the contract owner can disburse funds.");
        require(block.timestamp >= nextDistributionDate, "It's not time for disbursement.");
        require(!disbursing, "Disbursement is already in progress.");
        
        // Distribute investment proceeds equally among members
        for (uint256 i = 0; i < members.length; i++) {
            address member = members[i];
            balances[member] += poolAmount / members.length;
        }

        // Reset next distribution date
        nextDistributionDate = block.timestamp + 90 days;
        
        // Emit disbursement event
        emit Disbursed(poolAmount);

        // Flag disbursement as complete
        disbursing = false;
    }
    

    
    // Function to disburse funds to one person (monthly)
    function disburseToOnePerson() public {
        require(msg.sender == owner, "Only the contract owner can disburse funds.");
        require(block.timestamp >= endOfMonthDistributionDate, "It's not time for disbursement.");
        require(!disbursing, "Disbursement is already in progress.");

        // Calculate the total amount to be disbursed
        uint256 totalAmount = address(this).balance / 2;
       
        address member = members[lastMember];
        balances[member] += totalAmount;

        if(lastMember <= members.length){
            lastMember++;
        }else{
            lastMember = 0;
        }
        
        // send other half for investment
        poolAmount += totalAmount;

        // TODO: implement compound interest calculation

        // Emit disbursement event
        emit Disbursed(totalAmount);

        // Flag disbursement as complete
        disbursing = false;
    }

    // Function to check the last deposit time for the caller
    function getLastDepositTime() public view returns (uint256) {
        return lastDepositTimestamp[msg.sender];
        }

    
    // Function to get the balance of the current user
    function getMyBalance() public view returns (uint256) {
        address currentUser = msg.sender;
        return balances[currentUser];
    }

    

    // Additional functions (e.g., rotation mechanism and dismissal logic) can be added based on your requirements.
}
