const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying the contract with account:", deployer.address);

  const Todo = await ethers.getContractFactory("DecentralizedTodo");
  const todo = await Todo.deploy();

  await todo.deployed();

  console.log("DecentralizedTodo deployed to:", todo.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
