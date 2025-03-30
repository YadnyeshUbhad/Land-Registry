import React, { useState } from "react";

function FraudDetection() {
  const [riskScore, setRiskScore] = useState(null);
  const [features, setFeatures] = useState([0, 0, 0]); // Replace with actual feature inputs

  const checkFraudRisk = async () => {
    const response = await fetch("http://127.0.0.1:5000/predict", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ features }),
    });
    const data = await response.json();
    setRiskScore(data.fraud_risk);
    
  };

  return (
    <div>
      <h2>AI Fraud Detection</h2>
      <button onClick={checkFraudRisk}>Check Fraud Risk</button>
      {riskScore !== null && <p>Fraud Risk Score: {riskScore.toFixed(2)}</p>}
    </div>
  );
}

export default FraudDetection;
