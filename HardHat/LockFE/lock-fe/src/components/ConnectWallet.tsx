// ConnectWallet.jsx
import React from "react";
import { useMoralis } from "react-moralis";

export const ConnectWallet = () => {
  const { authenticate, isAuthenticating } = useMoralis();

  const handleConnect = async () => {
    try {
      await authenticate({
        signingMessage: "Authorize linking of your wallet to",
      });
    } catch (error) {
      console.error("Error connecting wallet:", error);
    }
  };

  return (
    <div className="flex flex-col">
      <button
        className="black"
        onClick={handleConnect}
        disabled={isAuthenticating}
      >
        {isAuthenticating ? "Loading" : "Connect Wallet"}
      </button>
    </div>
  );
};

// Export only the handleConnect function
export const connectWallet = ConnectWallet;
