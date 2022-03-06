import React, { useState, useContext, useRef } from "react";
import SearchIcon from "./icons/SearchIcon";
import ArrowLeftIcon from "./icons/ArrowLeftIcon";
import { AppContext } from "../App";
import ArrowRightIcon from "../components/icons/ArrowRightIcon";
import useOutsideClick from "../useOutsideClick";
import { useDispatch, useSelector } from "react-redux";
import { setAuth } from "../redux/reducers/authSlice";
import { logout } from "../api/userApi";
import ArrowDownIcon from "./icons/ArrowDownIcon";

const TopBar = () => {
  const dispatch = useDispatch();
  const {
    isSideBarOpen,
    setIsSideBarOpen,
    isBigScreen,
    setIsMenuOpen,
    setIsLoading,
  } = useContext(AppContext);
  const { user } = useSelector((state) => state.auth);
  const [isOpen, setIsOpen] = useState(false);

  const ref = useRef();

  useOutsideClick(ref, () => {
    if (isOpen) {
      setIsOpen(false);
    }
  });

  const toggleMenu = (e) => {
    e.preventDefault();

    setIsOpen((isOpen) => !isOpen);
  };

  const handleLogout = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    const { data } = await logout();
    dispatch(setAuth(data));
    setIsLoading(false);
  };

  return (
    <div className="w-full flex justify-between px-6 sticky top-0 z-20 items-center bg-white">
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
      </div>
      <div ref={ref} className="mr-4 rounded-full relative">
        <div onClick={toggleMenu} className="flex items-center cursor-pointer">
          <img
            className="h-10 w-10 rounded-full "
            src={
              user.profile
                ? user.profile
                : "https://images.unsplash.com/photo-1532074205216-d0e1f4b87368?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"
            }
            alt=""
          />
          <span className="text-black font-semibold tracking-wider pl-4">
            {user.username}
          </span>
          <ArrowDownIcon className="h-5 w-5" />
        </div>
        {isOpen && (
          <div className="flex flex-col justify-around absolute z-50 top-12 right-0 bg-white h-36 w-52 rounded-2xl shadow-lg pt-4 pb-2">
            <span className="text-gray-400 font-semibold tracking-wider pl-4">
              {user.email}
            </span>

            <div className="flex flex-col">
              <span className=" pl-4 text-gray-500 hover:bg-blue-light cursor-pointer py-2">
                <div>Settings</div>
              </span>

              <span className="pl-4 text-gray-500 hover:bg-blue-light cursor-pointer py-2">
                <div onClick={handleLogout}>Logout</div>
              </span>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default TopBar;
