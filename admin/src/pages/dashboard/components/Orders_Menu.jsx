import { XIcon } from "@heroicons/react/solid";
import React, { useRef } from "react";
import useOutsideClick from "../../../useOutsideClick";

const OrdersMenu = ({isOrderMenuOpen, setIsOrderMenuOpen }) => {
  const ref = useRef();

  useOutsideClick(ref, () => {
    if (isOrderMenuOpen) {
      setIsOrderMenuOpen(false);
    }
    
  });
  return (
    <div className="flex absolute z-40 right-0 w-full h-full backdrop-filter backdrop-blur-md">
      <div className="flex items-start absolute top-0 right-0 z-50 flex-col w-1/5 h-full px-5 pt-4 bg-bgColor-light ">
        <XIcon
          onClick={(e) => {
            e.preventDefault();
            setIsOrderMenuOpen(false);
          }}
          className="h-6 text-black mb-4 cursor-pointer"
        />
        <div className="flex items-center justify-between h-24 w-full bg-white rounded-3xl px-4 shadow-sm">
          <div className="flex">
            <div className="bg-customYellow-light w-16 h-16 rounded-2xl mr-3"></div>
            <div className="flex flex-col justify-center">
              <span className="text-black font-semibold">Arjun</span>
              <div className="flex">
                <span className="text-Grey-dark font-semibold mr-2">
                  items:
                </span>
                <span className="text-black font-semibold">14</span>
              </div>
            </div>
          </div>
          <div ref={ref} className="flex flex-col items-end">
            <span className="text-Grey-dark font-semibold mr-2">$234</span>
            <span className="text-black font-semibold">Complete</span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default OrdersMenu;
