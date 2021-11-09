import { TruckIcon } from "@heroicons/react/solid";
import React from "react";
import InfoIcon from "../../../components/icons/InfoIcon";
import InvoiceIcon from "../../../components/icons/InvoiceIcon";

const ActivityOverview = () => {
  return (
    <div className="flex flex-col">
      <span className="text-black font-semibold text-lg mb-3">
        Activity Overview
      </span>
      <div className="flex mb-4">
        <div className="flex flex-col items-center justify-evenly h-40 flex-grow bg-indigo-200 mr-4 rounded-3xl">
          <TruckIcon className="h-12 w-12 text-indigo-500" />
          <span className="text-black font-semibold tracking-wider text-lg">
            Delivered
          </span>
          <span className="text-black font-semibold tracking-wider text-lg">
            18
          </span>
        </div>
        <div className="flex flex-col items-center justify-evenly h-40 flex-grow bg-yellow-200 mr-4 rounded-3xl">
          <InvoiceIcon className="h-12 w-12 fill-yellow" />
          <span className="text-black font-semibold tracking-wider text-lg">
            Ordered
          </span>
          <span className="text-black font-semibold tracking-wider text-lg">
            18
          </span>
        </div>
      </div>
      <div className="flex">
        <div className="flex flex-col items-center justify-evenly h-40 flex-grow bg-customYellow-light bg-opacity-20 mr-4 rounded-3xl">
          <InfoIcon className="h-12 w-12 fill-yellow" />
          <span className="text-black font-semibold tracking-wider text-lg">
            Pending
          </span>
          <span className="text-black font-semibold tracking-wider text-lg">
            18
          </span>
        </div>
        <div className="flex flex-col items-center justify-evenly h-40 flex-grow bg-green-200 mr-4 rounded-3xl">
          <InfoIcon className="h-12 w-12 fill-green" />
          <span className="text-black font-semibold tracking-wider text-lg">
            Packed
          </span>
          <span className="text-black font-semibold tracking-wider text-lg">
            18
          </span>
        </div>
      </div>
    </div>
  );
};

export default ActivityOverview;
