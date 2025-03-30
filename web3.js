import Web3 from "web3";
import LandRegistryABI from "./LandRegistry.json"; // Import ABI file
import DAOABI from "./DAO.json";

const web3 = new Web3(window.ethereum); // Connect to MetaMask
const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3"; // Update this
const landRegistryContract = new web3.eth.Contract(LandRegistryABI, contractAddress);
const daoContract = new web3.eth.Contract(DAOABI, daoAddress);

export { daoContract };
export { web3, landRegistryContract };
