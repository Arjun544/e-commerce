import React, { useState, useContext } from "react";
import { AppContext } from "../App";
import BagIcon from "./icons/BagIcon";
import BannerIcon from "./icons/BannerIcon";
import CartIcon from "./icons/CartIcon";
import CategoryIcon from "./icons/CategoryIcon";
import ChatIcon from "./icons/ChatIcon";
import DashBoardIcon from "./icons/DashBoardIcon";
import FlashIcon from "./icons/FlashIcon";
import Logo from "./icons/Logo";
import PersonIcon from "./icons/PersonIcon";

const SideBar = () => {
  const { isSideBarOpen } = useContext(AppContext);
  const [selectedBar, setSelectedBar] = useState(0);
  return (
    <div
      className={`flex-col ${
        isSideBarOpen ? "w-72" : "w-20"
      } h-full pt-5 bg-darkBlue-light`}
    >
      <div
        className={`flex w-full items-start justify-start ${
          isSideBarOpen ? "ml-6" : "ml-3"
        }`}
      >
        <Logo />
      </div>

      {/* Menu tiems */}
      <div
        className={`flex flex-col items-${
          isSideBarOpen ? "start" : "center"
        } mt-16`}
      >
        {/* Dashboard */}

        <div
          onClick={(e) => setSelectedBar(0)}
          className={`flex w-${
            isSideBarOpen ? "48" : "42"
          }  items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <DashBoardIcon color={selectedBar === 0 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedBar === 0 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Dashboard
            </span>
          )}
        </div>

        {/* Orders */}
        <div
          onClick={(e) => setSelectedBar(1)}
          className={`flex w-${
            isSideBarOpen ? "48" : "42"
          }  items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <CartIcon color={selectedBar === 1 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedBar === 1 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Orders
            </span>
          )}
        </div>

        {/* Products */}
        <div
          onClick={(e) => setSelectedBar(2)}
          className={`flex w-${
            isSideBarOpen ? "48" : "42"
          }  items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <BagIcon color={selectedBar === 2 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedBar === 2 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Products
            </span>
          )}
        </div>

        {/*Categories  */}

        <div
          onClick={(e) => setSelectedBar(3)}
          className={`flex w-${
            isSideBarOpen ? "48" : "42"
          }  items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <CategoryIcon color={selectedBar === 3 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedBar === 3 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Categories
            </span>
          )}
        </div>

        {/* Banners */}

        <div
          onClick={(e) => setSelectedBar(4)}
          className={`flex w-${
            isSideBarOpen ? "48" : "42"
          }  items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <BannerIcon color={selectedBar === 4 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedBar === 4 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Banners
            </span>
          )}
        </div>

        {/* Deals */}

        <div
          onClick={(e) => setSelectedBar(5)}
          className={`flex w-${
            isSideBarOpen ? "48" : "42"
          }  items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <FlashIcon color={selectedBar === 5 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedBar === 5 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Deals
            </span>
          )}
        </div>

        {/* Customer */}

        <div
          onClick={(e) => setSelectedBar(6)}
          className={`flex w-${
            isSideBarOpen ? "48" : "42"
          }  items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <PersonIcon color={selectedBar === 6 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedBar === 6 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Customers
            </span>
          )}
        </div>

        {/* Customer Reviews */}

        <div
          onClick={(e) => setSelectedBar(7)}
          className={`flex w-${isSideBarOpen ? "48" : "42"} items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <ChatIcon color={selectedBar === 7 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedBar === 7 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Reviews
            </span>
          )}
        </div>
      </div>
    </div>
  );
};

export default SideBar;
