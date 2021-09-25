import React from "react";

const TopCustomers = () => {
  return (
    <div className="flex flex-col">
      <div className="flex items-center justify-between mb-4">
        <span className="text-black font-semibold text-lg">Top Customers</span>
        <span className="text-red-500 font-bold text-sm cursor-pointer hover:text-red-600">View All</span>
      </div>
      <div className="flex items-center justify-between h-24 w-full bg-white rounded-3xl px-4 shadow-sm">
        <div className="flex">
          <div className="bg-customYellow-light w-16 h-16 rounded-full mr-3"></div>
          <div className="flex flex-col justify-center">
            <span className="text-black font-semibold">Arjun</span>
            <div className="flex">
              <span className="text-Grey-dark font-semibold mr-2">Orders:</span>
              <span className="text-black font-semibold">14</span>
            </div>
          </div>
        </div>
        <div className="flex flex-col items-start">
          <span className="text-black font-semibold">Spent</span>
          <span className="text-Grey-dark font-semibold mr-2">$234</span>
        </div>
      </div>
    </div>
  );
};

export default TopCustomers;
