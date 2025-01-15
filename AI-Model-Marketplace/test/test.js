const Marketplace = artifacts.require("Marketplace");

contract("Marketplace", (accounts) => {
    it("should list a model", async () => {
        const marketplace = await Marketplace.deployed();
        await marketplace.listModel("AI Model", "Description", web3.utils.toWei("1", "ether"), { from: accounts[0] });
        const model = await marketplace.getModelDetails(0);
        assert.equal(model[0], "AI Model");
    });
});