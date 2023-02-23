const { expect } = require("chai");

describe("Token Contract", function () {
  let Token;
  let hardhatToken;
  let owner;
  let addr1;
  let addr2;
  let addrs;

  beforeEach(async function () {
    Token = await ethers.getContractFactory("Token");
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
    hardhatToken = await Token.deploy();
  });

  describe("Deployment", function () {
    it("Right owner", async function () {
        
        expect(await hardhatToken.owner()).to.equal(owner.address);
    });
    it("Assign the total supply to the owner", async function () {
      const ownerBalance = await hardhatToken.CheckBalance(owner.address);
      expect(await hardhatToken.totalsupply()).to.equal(ownerBalance);
    });
  });

  describe("Transactions", function () {
    it("Trasfer tokens", async function () {
      //owner account to addr1.address
      await hardhatToken.transfer(addr1.address, 5);
      const addr1Balance = await hardhatToken.CheckBalance(addr1.address);
      expect(addr1Balance).to.equal(5);

      await hardhatToken.connect(addr1).transfer(addr2.address, 5);
      const addr2Balance = await hardhatToken.CheckBalance(addr2.address);
      expect(addr2Balance).to.equal(5);
    });

    // it("Fail sender does not have enough tokens", async function () {
    //   const initialOwnerBalance = await hardhatToken.CheckBalance(owner.address);
    //   await expect(
    //     hardhatToken.connect(addr1).transfer(owner.address, 1) //Add1 has 0 token, its does not transfer token
    //   ).to.be.revertedWith("Not enough tokens");
    //   expect(await hardhatToken.CheckBalance(owner.address)).to.equal(
    //     initialOwnerBalance
    //   );
    // });

    it("balances Update", async function () {
      const initialOwnerBalance = await hardhatToken.CheckBalance(owner.address);
      await hardhatToken.transfer(addr1.address, 5);
      await hardhatToken.transfer(addr2.address, 10);

      const finalOwnerBalance = await hardhatToken.CheckBalance(owner.address);
      expect(finalOwnerBalance).to.equal(initialOwnerBalance - 15);

      const addr1Balance = await hardhatToken.CheckBalance(addr1.address);
      expect(addr1Balance).to.equal(5);
      const addr2Balance = await hardhatToken.CheckBalance(addr2.address);
      expect(addr2Balance).to.equal(10);
    });
  });
});