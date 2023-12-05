import React, { useState } from "react";
import { useWeb3Contract } from "react-moralis";
import { abi } from "../../constants/abi";

export default function LockComponent() {
  const [depositAmount, setDepositAmount] = useState("");
  const [withdrawAmount, setWithdrawAmount] = useState("");

  const { runContractFunction } = useWeb3Contract({
    abi: abi,
    contractAddress: "0xE9b3A1b1731115cc35d06C40caA375111b9bF80B",
    functionName: "deposit",
    params: {
      amount: depositAmount,
    },
  });

  const handleDeposit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    runContractFunction({ value: depositAmount } as any);
  };

  const handleWithdraw = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    runContractFunction();
  };

  return (
    <form onSubmit={handleDeposit}>
      <div className="space-y-12">
        <div className="grid grid-cols-1 gap-x-8 gap-y-10 border-b border-gray-900/10 pb-12 md:grid-cols-3">
          <div>
            <h2 className="text-base font-semibold leading-7 text-gray-900">
              Lock
            </h2>
            <p className="mt-1 text-sm leading-6 text-gray-600">
              This dapp defines a time-locked wallet, allowing the owner to
              deposit and withdraw funds. The unlock time is set during
              deployment, and withdrawals are permitted only after reaching the
              specified time, with events emitted for deposit and withdrawal
              actions.
            </p>
          </div>

          <div className="grid max-w-2xl grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6 md:col-span-2">
            <div className="sm:col-span-4">
              <label
                htmlFor="deposit_amount"
                className="block text-sm font-medium leading-6 text-gray-900"
              >
                Deposit
              </label>
              <div className="mt-2">
                <div className="flex rounded-md shadow-sm ring-1 ring-inset ring-gray-300 focus-within:ring-2 focus-within:ring-inset focus-within:ring-indigo-600 sm">
                  <input
                    type="number"
                    name="deposit_amount"
                    id="deposit_amount"
                    className="block flex-1 border-0 bg-transparent py-1.5 pl-1 text-gray-900 placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6"
                    placeholder="0.001 ETH"
                  />
                </div>
                <p className="mt-3 text-sm leading-6 text-gray-600">
                  Enter an amount you would like to deposit.
                </p>
              </div>
            </div>

            <div className="sm:col-span-4">
              <label
                htmlFor="deposit_amount"
                className="block text-sm font-medium leading-6 text-gray-900"
              >
                Withdraw
              </label>
              <div className="mt-2">
                <div className="flex rounded-md shadow-sm ring-1 ring-inset ring-gray-300 focus-within:ring-2 focus-within:ring-inset focus-within:ring-indigo-600 sm">
                  <input
                    type="number"
                    name="withdraw_amount"
                    id="withdraw_amount"
                    className="block flex-1 border-0 bg-transparent py-1.5 pl-1 text-gray-900 placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6"
                    placeholder="0.001 ETH"
                  />
                </div>
                <p className="mt-3 text-sm leading-6 text-gray-600">
                  Enter an amount you would like to withdraw.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="mt-6 flex items-center justify-center gap-x-6">
        <button
          type="button"
          className="text-sm font-semibold leading-6 text-gray-900"
        >
          Cancel
        </button>

        <button
          type="submit"
          className="rounded-md bg-indigo-900 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
        >
          Deposit
        </button>
        <button
          type="submit"
          className="rounded-md bg-indigo-900 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
        >
          Withdraw
        </button>
      </div>
    </form>
  );
}
