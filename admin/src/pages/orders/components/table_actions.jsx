import React, { useState, useRef } from "react";
import { CheckIcon, DotsVerticalIcon, XIcon } from "@heroicons/react/solid";
import useOutsideClick from "../../../useOutsideClick";

const TableActions = ({ value}) => {
  const [isOpen, setIsOpen] = useState(false);
  const ref = useRef();

  useOutsideClick(ref, () => {
    if (isOpen) {
      setIsOpen(false);
    }
  });

  return (
    <div ref={ref} onClick={(e) => setIsOpen(true)} className="flex-col">
      <div className="flex items-center justify-center cursor-pointer hover:text-customYellow-light">
        <DotsVerticalIcon className="h-5" />
      </div>
      {isOpen && (
        <div className="flex flex-col absolute z-50 h-auto w-32 rounded-2xl mt-1 py-1 bg-white shadow-md">
          <div className="flex justify-center items-center px-4 py-2 cursor-pointer hover:bg-blue-light">
            <CheckIcon className="h-5 mr-2 text-green-500" />
            <span className="text-green-500 font-semibold text-base ">
              Accept
            </span>
          </div>

          <div className="flex justify-center items-center px-4 py-2 cursor-pointer hover:bg-blue-light">
            <XIcon className="h-5 mr-2 text-red-500" />
            <span className="text-red-500 font-semibold text-base ">
              Reject
            </span>
          </div>
        </div>
      )}
    </div>
  );
};

export default TableActions;
