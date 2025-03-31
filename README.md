# Land Registry Blockchain Project

## 📌 Overview
The **Land Registry Blockchain Project** is a decentralized application (DApp) that ensures secure, tamper-proof, and transparent land ownership records using **Ethereum blockchain & smart contracts**. This system eliminates fraud and reduces paperwork while providing a **trustless** and **immutable** record of land transactions.

## 🚀 Features
- **Decentralized Land Ownership Records** 📜
- **Smart Contract-Based Transactions** 🏡
- **Immutable & Tamper-Proof Data** 🔐
- **Transparency & Security** 🔍
- **Metamask Integration for Secure Transactions** 🦊
- **Web3-Based User Interface** 🌐
- **Role-Based Access (Admin, Buyer, Seller)** 🔑

## 🛠️ Technologies Used
- **Solidity** – Smart contract development
- **Ethereum & Hardhat** – Blockchain network
- **React.js** – Frontend development
- **Web3.js / Ethers.js** – Blockchain interaction
- **IPFS (Optional)** – Decentralized storage for land documents
- **Truffle / Hardhat** – Smart contract testing & deployment

## ⚙️ Smart Contract Setup

### **1️⃣ Prerequisites**
Make sure you have the following installed:
```sh
npm install -g hardhat # or truffle
npm install -g ganache-cli
npm install -g @openzeppelin/contracts
```

### **2️⃣ Clone the Repository**
```sh
git clone https://github.com/YadnyeshUbhad/Land-Registry.git
cd Land-Registry
```

### **3️⃣ Install Dependencies**
```sh
npm install
```

### **4️⃣ Compile Smart Contracts**
```sh
npx hardhat compile
```

### **5️⃣ Deploy Locally (Using Ganache)**
```sh
npx hardhat node
npx hardhat run scripts/deploy.js --network localhost
```

### **6️⃣ Deploy to a Testnet (Goerli/Sepolia/Mumbai)**
Ensure you have **Infura/Alchemy API key** and **Metamask private key** set up in `.env`:
```sh
npx hardhat run scripts/deploy.js --network sepolia
```

### **7️⃣ Verify Smart Contract (Etherscan)**
```sh
npx hardhat verify --network sepolia YOUR_CONTRACT_ADDRESS
```

## 🖥️ Frontend Setup
### **1️⃣ Run Development Server**
```sh
cd frontend
npm install
npm start
```
**URL:** `http://localhost:3000`

### **2️⃣ Connect to Metamask**
- Open Metamask & connect to **Sepolia Testnet**
- Import contract address
- Interact with the blockchain UI

## 🚀 Deployment (Frontend)
### **1️⃣ Vercel / Netlify Deployment**
```sh
npm run build
vercel deploy # OR netlify deploy
```

### **2️⃣ IPFS Deployment (Optional)**
```sh
npm install -g pinata-cli
pinata-cli pinFileToIPFS ./build
```

## 📜 License
This project is **open-source** under the [MIT License](LICENSE).

## 📞 Contact
For any queries or contributions, contact [Yadnyesh Ubhad](https://github.com/YadnyeshUbhad) [Sahil Sanap].

