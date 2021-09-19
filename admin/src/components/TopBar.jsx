import React, { useContext } from "react";
import SearchIcon from "./icons/SearchIcon";
import ArrowLeftIcon from "./icons/ArrowLeftIcon";
import { AppContext } from "../App";
import ArrowRightIcon from "../components/icons/ArrowRightIcon";

const TopBar = () => {
  const { isSideBarOpen, setIsSideBarOpen, isBigScreen, setIsMenuOpen } =
    useContext(AppContext);
  return (
    <div className="w-full flex justify-between px-6 my-6 items-center bg-white">
      <div className="flex h-12 w-1/2 items-center">
        <div
          onClick={
            isBigScreen
              ? (e) => setIsSideBarOpen((preState) => !preState)
              : (e) => setIsMenuOpen(true)
          }
          className="cursor-pointer"
        >
          {isBigScreen ? (
            isSideBarOpen ? (
              <ArrowLeftIcon />
            ) : (
              <ArrowRightIcon />
            )
          ) : (
            <svg
              xmlns="http://www.w3.org/2000/svg"
              className="h-5 w-5"
              viewBox="0 0 20 20"
              fill="currentColor"
            >
              <path
                fillRule="evenodd"
                d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h6a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
                clipRule="evenodd"
                color="#000"
              />
            </svg>
          )}
        </div>

        <div
          className={`flex h-12 w-${
            isBigScreen ? "1/2" : "full"
          } items-center pl-4 ml-28 rounded-xl placeholder-gray-200 bg-gray-100`}
        >
          <SearchIcon />
          <input
            className="text-sm  flex-grow font-semibold pl-4 text-black bg-gray-100 border-0 outline-none"
            type="text"
            placeholder="Search here"
          />
        </div>
      </div>

      <img
        className="h-10 w-10 mr-4 rounded-full"
        src="assets/images/profile.jpg"
        alt=""
      />
    </div>
  );
};

export default TopBar;
