import Image from "next/image";
import React from "react";
import Footer from "../components/Footer";
import LockComponent from "../components/LockComponent";
import NavBar from "../components/NavBar";
import { useMoralis, useWeb3Contract } from "react-moralis";


export default function Home() {
const {enableWeb3, isWeb3Enabled} = useMoralis();

  return (
    <>
      <NavBar />
      <div className="p-10">
        <LockComponent />
      </div>
   
      <Footer />
    </>
  );
}
