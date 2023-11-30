/* eslint-disable @next/next/no-img-element */
import { useState } from "react";
import { Dialog } from "@headlessui/react";
import { Bars3Icon, XMarkIcon } from "@heroicons/react/24/outline";
import { useConnect } from "wagmi";
import { MetaMaskConnector } from "wagmi/connectors/metaMask";

const navigation = [{ name: "Account", href: "#" }];

export default function NavBar() {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const { connectAsync } = useConnect();
  const [isConnected, setIsConnected] = useState(false);

  const handleAuth = async () => {
    try {
      const { account, chain } = await connectAsync({
        connector: new MetaMaskConnector(),
      });

      const userData = { address: account, chainId: chain.id };
      console.log(userData);

      // Update connection status
      setIsConnected(true);
    } catch (error) {
      console.error("Failed to connect:", error);
      // Handle connection error if needed
    }
  };

  return (
    <header className="bg-white">
      <nav
        className="mx-auto flex max-w-7xl items-center justify-between p-6 lg:px-8"
        aria-label="Global"
      >
        <div className="flex flex-1">
          <div className="flex lg:hidden">
            <button
              type="button"
              className="-m-2.5 inline-flex items-center justify-center rounded-md p-2.5 text-gray-700"
              onClick={() => setMobileMenuOpen(true)}
            >
              <span className="sr-only">Open main menu</span>
              <Bars3Icon className="h-6 w-6" aria-hidden="true" />
            </button>
          </div>
        </div>
        <a href="#" className="-m-1.5 p-1.5">
          <span className="sr-only">RAGESTATE Labs</span>
          <img
            className="h-8 w-auto"
            src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=900"
            alt=""
          />
        </a>
        <div className="flex flex-1 justify-end">
          {isConnected ? (
            <span className="text-indigo-900 font-semibold border border-indigo-900 rounded-md px-3 py-2 text-sm shadow-sm">
              Connected
            </span>
          ) : (
            <button
              type="submit"
              className="rounded-md bg-indigo-900 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
              onClick={handleAuth}
            >
              Connect Wallet
            </button>
          )}
        </div>
      </nav>
      <Dialog
        as="div"
        className="lg:hidden"
        open={mobileMenuOpen}
        onClose={setMobileMenuOpen}
      >
        <div className="fixed inset-0 z-10" />
        <Dialog.Panel className="fixed inset-y-0 left-0 z-10 w-full overflow-y-auto bg-white px-6 py-6">
          <div className="flex items-center justify-between">
            <div className="flex flex-1">
              <button
                type="button"
                className="-m-2.5 rounded-md p-2.5 text-gray-700"
                onClick={() => setMobileMenuOpen(false)}
              >
                <span className="sr-only">Close menu</span>
                <XMarkIcon className="h-6 w-6" aria-hidden="true" />
              </button>
            </div>

            <div className="flex flex-1 justify-end">
              {isConnected ? (
                <span className="text-indigo-900 font-semibold border border-indigo-900 rounded-md px-3 py-2 text-sm shadow-sm">
                  Connected
                </span>
              ) : (
                <button
                  type="submit"
                  className="rounded-md bg-indigo-900 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                  onClick={handleAuth}
                >
                  Connect Wallet
                </button>
              )}
            </div>
          </div>
          <div className="mt-6 space-y-2">
            {navigation.map((item) => (
              <a
                key={item.name}
                href={item.href}
                className="-mx-3 block rounded-lg px-3 py-2 text-base font-semibold leading-7 text-gray-900 hover:bg-gray-50"
              >
                {item.name}
              </a>
            ))}
          </div>
        </Dialog.Panel>
      </Dialog>
    </header>
  );
}
