const PiToken = artifacts.require("PiToken");

module.exports = async function(deployer) {
    await deployer.deploy(PiToken,"1000");
};