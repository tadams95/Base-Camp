import "@/styles/globals.css";
import type { AppProps } from "next/app";
import { createConfig, configureChains, WagmiConfig } from "wagmi";
import { publicProvider } from "wagmi/providers/public";
import { SessionProvider } from "next-auth/react";
import { mainnet } from "wagmi/chains";
import { MoralisProvider } from "react-moralis";
import React from "react";

const { publicClient, webSocketPublicClient } = configureChains(
  [mainnet],
  [publicProvider()]
);

const config = createConfig({
  autoConnect: true,
  publicClient,
  webSocketPublicClient,
});

export default function App({ Component, pageProps }: AppProps) {
  return (
    // <WagmiConfig config={config}>
    //   <SessionProvider session={pageProps.session} refetchInterval={0}>
    <>
      <MoralisProvider initializeOnMount={false}>
        <Component {...pageProps} />
      </MoralisProvider>
    </>
    //   </SessionProvider>
    // </WagmiConfig>
  );
}
