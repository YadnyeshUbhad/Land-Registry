
🏡 Land Registry (BlockChain-Based)

A decentralized land registry system built using Solidity, Web3.js, HTML, CSS, and JavaScript, designed for secure and transparent land transactions. Unlike traditional DApps, this project does not use MetaMask and interacts directly with Ganache.


📌 Features

✅ Register Land – Users can register land with unique details.

✅ List Land for Sale – Owners can list land for sale with a specified price.

✅ Fetch Land Details – Retrieve land details using Land ID.

✅ Raise Disputes – Users can raise disputes regarding a land transaction.

✅ Transfer Ownership – Ownership can be transferred to another user with validation.

✅ Direct Ganache Integration – Uses Ganache for blockchain interaction (No MetaMask Required).




📂 Project Structure


/land-registry-BlockChain-Based

│── /contracts                 # Solidity smart contract files

│    ├── LandRegistry.sol       # Main Land Registry Smart Contract

│── /frontend                   # Frontend code (HTML, CSS, JS)

│    ├── frontend.html             # Main UI file

│── /migrations                 # Deployment scripts for Truffle

│── truffle-config.js           # Truffle configuration file

│── package.json                # Dependencies and scripts

│── README.md                   # Project documentation


🔧 Prerequisites

Ensure you have the following installed before proceeding:

1️⃣ Install Node.js & NPM

Download and install Node.js (which includes npm) from here.

To check if it's installed, run:

node -v

npm -v


2️⃣ Install Ganache

Ganache provides a local Ethereum blockchain for testing.

GUI Version: Download from Truffle Suite

CLI Version (if using command line):

npm install -g ganache-cli


3️⃣ Install Truffle

Truffle is used for compiling and deploying smart contracts.

npm install -g truffle

To verify installation, run:

truffle version


🚀 Setup & Execution

1️⃣ Clone the Repository

git clone https://github.com/YadnyeshUbhad/land-registry.git

cd land-registry


2️⃣ Start Ganache

If using the GUI version:


Open Ganache, create a new workspace, and start the local blockchain.

Note down the RPC Server address (usually http://127.0.0.1:7545).

If using CLI version, run:

ganache-cli

This will start a local blockchain with 10 accounts and 100 ETH each.


3️⃣ Install Dependencies

npm install



4️⃣ Compile the Smart Contract:

truffle compile

This compiles the LandRegistry.sol contract.


5️⃣ Deploy the Smart Contract

truffle migrate --reset

This will deploy the contract to the local Ganache blockchain.


📌 Copy the deployed contract address from the output, as it will be used in the frontend.

6️⃣ Configure Frontend

Open frontend.html

Replace the contract address in the following line with the one from deployment:

const contractAddress = "YOUR_DEPLOYED_CONTRACT_ADDRESS";


7️⃣ Run the Frontend

Simply open frontend.html in your browser.


✅ The app will connect to Ganache and allow interactions with the smart contract.


📜 Smart Contract Functions

Function	Description

registerLand(landId, ownerName, location, area, geoTag, tokenURI)	Registers a new land on the blockchain

listLandForSale(landId, price)	Lists land for sale with a specified price

getLandDetails(landId)	Fetches land details based on the Land ID

raiseDispute(landId, reason)	Allows users to raise disputes regarding a land

transferOwnership(landId, newOwnerAddress)	Transfers land ownership to a new owner


🎯 Future Enhancements

🔹 Implement IPFS for decentralized document storage

🔹 Add User Authentication for enhanced security

🔹 Implement Smart Contract Events for real-time notifications


🏆 Contributing

Contributions are welcome! Feel free to fork this repository, make improvements, and submit a pull request.


🔗 Connect with Me

📩 Have questions or suggestions? Reach out via GitHub Issues or Discussions!
