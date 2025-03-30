import React, { useState, useEffect } from "react";
import { web3, landRegistryContract } from "./web3";

function App() {
  const [account, setAccount] = useState("");
  const [landDetails, setLandDetails] = useState([]);
  const [ownerName, setOwnerName] = useState("");
  const [location, setLocation] = useState("");
  const [area, setArea] = useState("");
  const [geoTag, setGeoTag] = useState("");
  const [tokenURI, setTokenURI] = useState("");

  // Connect to MetaMask
  const connectWallet = async () => {
    if (window.ethereum) {
      const accounts = await web3.eth.requestAccounts();
      setAccount(accounts[0]);
    } else {
      alert("Please install MetaMask.");
    }
  };

  // Register a new land
  const registerLand = async () => {
    try {
      await landRegistryContract.methods
        .registerLand(Date.now(), ownerName, location, area, geoTag, tokenURI)
        .send({ from: account });

      alert("Land registered successfully!");
      fetchLands();
    } catch (error) {
      console.error("Error registering land:", error);
    }
  };

  // Fetch land details
  const fetchLands = async () => {
    try {
      const totalLands = await landRegistryContract.methods.getUserLands(account).call();
      let lands = [];

      for (let id of totalLands) {
        let land = await landRegistryContract.methods.getLandDetails(id).call();
        lands.push(land);
      }

      setLandDetails(lands);
    } catch (error) {
      console.error("Error fetching lands:", error);
    }
  };

  useEffect(() => {
    if (account) fetchLands();
  }, [account]);

  return (
    <div className="container">
      <h1>Land Registry DApp</h1>

      {!account ? (
        <button onClick={connectWallet}>Connect MetaMask</button>
      ) : (
        <div>
          <h2>Connected Account: {account}</h2>

          <h3>Register Land</h3>
          <input type="text" placeholder="Owner Name" onChange={(e) => setOwnerName(e.target.value)} />
          <input type="text" placeholder="Location" onChange={(e) => setLocation(e.target.value)} />
          <input type="number" placeholder="Area (sq ft)" onChange={(e) => setArea(e.target.value)} />
          <input type="text" placeholder="GeoTag" onChange={(e) => setGeoTag(e.target.value)} />
          <input type="text" placeholder="Token URI" onChange={(e) => setTokenURI(e.target.value)} />
          <button onClick={registerLand}>Register Land</button>

          <h3>Registered Lands</h3>
          <ul>
            {landDetails.map((land, index) => (
              <li key={index}>
                <b>Owner:</b> {land.ownerName}, <b>Location:</b> {land.location}, <b>Area:</b> {land.area} sq ft
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}

export default App;
