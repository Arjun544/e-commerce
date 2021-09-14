import React, { useContext } from "react";
import SearchIcon from "./icons/SearchIcon";
import ArrowLeftIcon from "./icons/ArrowLeftIcon";
import { AppContext } from "../App";

const TopBar = () => {
  const { setIsSideBarOpen } = useContext(AppContext);
  return (
    <div className="w-full flex justify-between px-4 h-24 items-center bg-white">
      <div className="flex h-12 w-1/2 items-center">
        <div
          onClick={(e) => setIsSideBarOpen((preState) => !preState)}
          className="cursor-pointer"
        >
          <ArrowLeftIcon />
        </div>

        <div className="flex h-12 w-1/2 items-center pl-4 ml-28 rounded-xl placeholder-gray-200 bg-gray-100">
          <SearchIcon />
          <input
            className="text-sm   flex-grow font-semibold pl-4 bg-gray-100 border-0 outline-none"
            type="text"
            placeholder="Search here"
          />
        </div>
      </div>

      <img
        className="h-10 w-10 rounded-full"
        src="assets/images/profile.jpg"
        alt=""
      />
    </div>
  );
};

export default TopBar;
