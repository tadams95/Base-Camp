import Image from "next/image";
// import { Inter } from 'next/font/google'
import NavBar from "@/components/NavBar";
import Footer from "@/components/Footer";
import LockComponent from "@/components/LockComponent";
// import { useEvmNativeBalance,  } from "@moralisweb3/next";

// const inter = Inter({ subsets: ['latin'] })

export default function Home() {
  // const address = "0x60e1229dd08be81ddc24ab40e2bcabe78f419ed6";
  // const { data: nativeBalance } = useEvmNativeBalance({ address });

  return (
    <>
      <NavBar />
      <div className="p-10">
        <LockComponent />
      </div>
      {/* <div>
        <h3>Wallet: {address}</h3>
        <h3>Native Balance: {nativeBalance?.balance.ether} ETH</h3>
      </div> */}

      <Footer />
    </>
  );
}
