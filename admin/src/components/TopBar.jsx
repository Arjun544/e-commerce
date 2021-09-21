import React, { useState, useContext } from "react";
import SearchIcon from "./icons/SearchIcon";
import ArrowLeftIcon from "./icons/ArrowLeftIcon";
import { AppContext } from "../App";
import ArrowRightIcon from "../components/icons/ArrowRightIcon";
import { useSelector } from "react-redux";

const TopBar = () => {
  const { isSideBarOpen, setIsSideBarOpen, isBigScreen, setIsMenuOpen } =
    useContext(AppContext);
  const { auth, user } = useSelector((state) => state.auth);

  return (
    <div className="w-full flex justify-between px-6 sticky top-0 z-50 items-center bg-white">
      <div className="flex h-24  w-1/2 items-center">
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

      {!auth && (
        <img
          className="h-10 w-10 mr-4 rounded-full"
          src="https://images.unsplash.com/photo-1532074205216-d0e1f4b87368?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"
          alt=""
        />
      )}
    </div>
  );
};

export default TopBar;
