const { expect } = require("chai");

describe("SusuContract", function () {
  let SusuContract, susuContract, owner, addr1, addr2;

  beforeEach(async function () {
    SusuContract = await ethers.getContractFactory("SusuContract");
    susuContract = await SusuContract.deploy();
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
  });

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      expect(await susuContract.owner()).to.equal(owner.address);
    });
  });

  describe("Joining Susu", function () {
    it("Should allow a user to join", async function () {
      await susuContract.connect(addr1).joinSusu();
      expect(await susuContract.balances(addr1.address)).to.equal(0);
    });

    it("Should prevent the contract owner from joining", async function () {
      await expect(susuContract.joinSusu()).to.be.revertedWith("The contract owner cannot join.");
    });
  });

  describe("Making Deposits", function () {
    it("Should allow a user to make a deposit", async function () {
      await susuContract.connect(addr1).joinSusu();
      await susuContract.connect(addr1).makeDeposit();
      expect(await susuContract.balances(addr1.address)).to.equal(50);
    });
  });

  describe("Yearly Disbursement", function () {
    // it("Should disburse funds equally among members", async function () {
    //   // Set the nextDistributionDate to the past to allow disbursement

    //   const initialBalance = await ethers.provider.getBalance(addr1.address);
    //   await susuContract.disburseFunds();

    //   const finalBalance = await ethers.provider.getBalance(addr1.address);
    //   console.log(finalBalance,"final balance")
    //   expect(finalBalance.sub(initialBalance)).to.equal(expectedAmount);  // Replace expectedAmount with the expected disbursement amount
    // });

    it("Should revert if it's not time for disbursement", async function () {
      await expect(susuContract.disburseFunds()).to.be.revertedWith("It's not time for disbursement.");
    });
  });

  describe("Monthly Disbursement to One Person", function () {
    // it("Should disburse half the contract balance to one member", async function () {
    //   // Set the endOfMonthDistributionDate to the past to allow disbursement
    //   await network.provider.send("evm_increaseTime", [30 * 24 * 60 * 60]);
    //   await network.provider.send("evm_mine");  // This will mine a new block with the updated timestamp

    //   const initialContractBalance = await ethers.provider.getBalance(addr1.address);
    //   const initialMemberBalance = await susuContract.balances(addr1.address);

    //   await susuContract.disburseToOnePerson();

    //   const finalMemberBalance = await susuContract.balances(addr1.address);
    //   expect(finalMemberBalance.sub(initialMemberBalance)).to.equal(initialContractBalance.div(2));
    // });

    it("Should revert if it's not time for disbursement", async function () {
      await expect(susuContract.disburseToOnePerson()).to.be.revertedWith("It's not time for disbursement.");
    });

  });

});