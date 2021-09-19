import React from "react";

const RightContainer = () => {
  return (
    <div className="flex flex-col flex-grow rounded-3xl px-5 pt-6 bg-bgColor-light">
      <div className="flex justify-between">
        <span className="text-black font-semibold mb-4">Latest Orders</span>
        <span className="text-green-600 font-semibold mb-4">View all</span>
      </div>
      <div className="flex items-center justify-between h-24 w-full bg-white rounded-3xl px-4 shadow-sm">
        <div className="flex">
          <div className="bg-customYellow-light w-16 h-16 rounded-2xl mr-3"></div>
          <div className="flex flex-col justify-center">
            <span className="text-black font-semibold">Arjun</span>
            <div className="flex">
              <span className="text-Grey-dark font-semibold mr-2">items:</span>
              <span className="text-black font-semibold">14</span>
            </div>
          </div>
        </div>
        <div className="flex flex-col items-end">
          <span className="text-Grey-dark font-semibold mr-2">$234</span>
          <span className="text-black font-semibold">Complete</span>
        </div>
      </div>
    </div>
  );
};

export default RightContainer;
