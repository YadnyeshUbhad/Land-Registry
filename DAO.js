import React, { useState, useEffect } from "react";
import { daoContract, web3 } from "./web3";

function DAO() {
  const [account, setAccount] = useState("");
  const [proposals, setProposals] = useState([]);
  const [reason, setReason] = useState("");

  const connectWallet = async () => {
    const accounts = await web3.eth.requestAccounts();
    setAccount(accounts[0]);
  };

  const createProposal = async () => {
    await daoContract.methods.createProposal(reason).send({ from: account });
    fetchProposals();
  };

  const voteProposal = async (id, support) => {
    await daoContract.methods.vote(id, support).send({ from: account });
    fetchProposals();
  };

  const fetchProposals = async () => {
    const totalProposals = await daoContract.methods.proposalCount().call();
    let tempProposals = [];
    for (let i = 1; i <= totalProposals; i++) {
      let proposal = await daoContract.methods.proposals(i).call();
      tempProposals.push(proposal);
    }
    setProposals(tempProposals);
  };

  useEffect(() => {
    if (account) fetchProposals();
  }, [account]);

  return (
    <div>
      <h2>DAO Governance</h2>
      {!account ? (
        <button onClick={connectWallet}>Connect MetaMask</button>
      ) : (
        <div>
          <input type="text" placeholder="Dispute Reason" onChange={(e) => setReason(e.target.value)} />
          <button onClick={createProposal}>Submit Dispute</button>
          
          <h3>Proposals</h3>
          {proposals.map((p) => (
            <div key={p.id}>
              <p>{p.reason} - Upvotes: {p.upvotes} | Downvotes: {p.downvotes}</p>
              <button onClick={() => voteProposal(p.id, true)}>Upvote</button>
              <button onClick={() => voteProposal(p.id, false)}>Downvote</button>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

export default DAO;
