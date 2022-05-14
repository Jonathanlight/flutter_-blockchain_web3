const HelloWorld = artifacts.require("HelloWorld");

contract("HelloWorld", () => {
    it("Testing", async() => {
        const MessageFix = "Hello Jonathan";
        const instance = await HelloWorld.deployed();
        await instance.setMessage("Hello Jonathan");
        const message = await instance.message();
        assert(message === MessageFix);
    })
})