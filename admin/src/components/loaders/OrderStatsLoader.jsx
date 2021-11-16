import React, { useContext } from "react";
import { AppContext } from "../../App";

const OrderStatsLoader = () => {
  const { isBigScreen } = useContext(AppContext);
  return (
    <div className="grid grid-flow-col grid-rows-1 gap-4 px-6 w-full py-6 rounded-3xl mt-6 bg-bgColor-light">
      <div className="animate-pulse flex space-x-4">
        <div className="flex flex-col w-full justify-between">
          <div className="flex justify-between items-center mb-4">
            <div className="h-6 w-20 bg-gray-200 mb-2"></div>
            <div className="h-12 w-40 bg-gray-200 mb-2 rounded-xl"></div>
          </div>
          <div
            className={`${
              isBigScreen
                ? "flex w-full justify-between items-center mr-4"
                : "grid grid-flow-col grid-rows-4 gap-4"
            }`}
          >
            <div className="flex">
              <div className="flex h-12 w-14 items-center justify-center rounded-2xl mr-4 bg-gray-200"></div>
              <div className="flex flex-col item justify-center">
                <div className="h-3 w-12 bg-gray-200 mb-2"></div>
                <div className="h-3 w-5 bg-gray-200"></div>
              </div>
            </div>
            <div className="flex">
              <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-gray-200"></div>
              <div className="flex flex-col item justify-center">
                <div className="h-3 w-12 bg-gray-200 mb-2"></div>
                <div className="h-3 w-5 bg-gray-200"></div>
              </div>
            </div>

            <div className="flex">
              <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-gray-200"></div>
              <div className="flex flex-col item justify-center">
                <div className="h-3 w-12 bg-gray-200 mb-2"></div>
                <div className="h-3 w-5 bg-gray-200"></div>
              </div>
            </div>

            <div className="flex">
              <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-gray-200"></div>
              <div className="flex flex-col item justify-center">
                <div className="h-3 w-12 bg-gray-200 mb-2"></div>
                <div className="h-3 w-5 bg-gray-200"></div>
              </div>
            </div>

            <div className="flex">
              <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-gray-200"></div>
              <div className="flex flex-col item justify-center">
                <div className="h-3 w-12 bg-gray-200 mb-2"></div>
                <div className="h-3 w-5 bg-gray-200"></div>
              </div>
            </div>

            <div className="flex">
              <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-gray-200"></div>
              <div className="flex flex-col item justify-center">
                <div className="h-3 w-12 bg-gray-200 mb-2"></div>
                <div className="h-3 w-5 bg-gray-200"></div>
              </div>
            </div>

            <div className="flex">
              <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-gray-200"></div>
              <div className="flex flex-col item justify-center">
                <div className="h-3 w-12 bg-gray-200 mb-2"></div>
                <div className="h-3 w-5 bg-gray-200"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default OrderStatsLoader;
