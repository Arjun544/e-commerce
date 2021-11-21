import React, { useState, useContext, useEffect } from "react";
import { AppContext } from "../App";
import { useHistory } from "react-router-dom";
import BagIcon from "./icons/BagIcon";
import BannerIcon from "./icons/BannerIcon";
import CartIcon from "./icons/CartIcon";
import CategoryIcon from "./icons/CategoryIcon";
import ChatIcon from "./icons/ChatIcon";
import DashBoardIcon from "./icons/DashBoardIcon";
import FlashIcon from "./icons/FlashIcon";
import Logo from "./icons/Logo";
import PersonIcon from "./icons/PersonIcon";
import { createBrowserHistory } from "history";

const SideBar = () => {
  const history = useHistory();
  const createHistory = createBrowserHistory();
  const {selectedSideBar, setSelectedSideBar, isSideBarOpen, isBigScreen, isMenuOpen, setIsMenuOpen } =
    useContext(AppContext);

  useEffect(() => {
    switch (createHistory.location.pathname) {
      case "/":
        setSelectedSideBar(0);
        break;
      case "/orders":
        setSelectedSideBar(1);
        break;
      case "/products":
        setSelectedSideBar(2);
        break;
      case "/categories":
        setSelectedSideBar(3);
        break;
      case "/banners":
        setSelectedSideBar(4);
        break;
      case "/flashDeal":
        setSelectedSideBar(5);
        break;
      case "/customers":
        setSelectedSideBar(6);
        break;
      case "/reviews":
        setSelectedSideBar(7);
        break;
      default:
        break;
    }
  }, []);

  return (
    <div
      className={`flex-col ${
        isSideBarOpen ? "w-72" : "w-20"
      } h-full pt-5 bg-darkBlue-light transition-width duration-400  ease`}
    >
      {isBigScreen ? (
        <div
          className={`flex w-full items-center ${
            isSideBarOpen ? "ml-6 " : "ml-5"
          }`}
        >
          <Logo color={"#ffff"} />
          {isSideBarOpen && (
            <div>
              <span className="text-lg font-semibold ml-2 tracking-wider">
                Sell
              </span>
              <span className="text-lg font-semibold text-customYellow-light tracking-wider">
                Corner
              </span>
            </div>
          )}
        </div>
      ) : (
        isMenuOpen && (
          <div className="flex items-center justify-between px-6">
            <div className="flex items-center">
              <Logo color={"#ffff"} />
              <span className="text-lg font-semibold ml-2 tracking-wider">
                Sell
              </span>
              <span className="text-lg font-semibold text-customYellow-light tracking-wider">
                Corner
              </span>
            </div>
            <div
              onClick={(e) => setIsMenuOpen(false)}
              className="cursor-pointer"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="h-5 w-5"
                viewBox="0 0 20 20"
                fill="currentColor"
              >
                <path
                  fillRule="evenodd"
                  d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                  clipRule="evenodd"
                />
              </svg>
            </div>
          </div>
        )
      )}

      {/* Menu tiems */}

      <div
        className={`flex flex-col items-${
          isSideBarOpen ? "start" : "center"
        } mt-16`}
      >
        {/* Dashboard */}

        <div
          onClick={(e) => {
            setSelectedSideBar(0);
            history.push("/");
          }}
          className={`flex w-${
            isSideBarOpen ? "48" : "42"
          }  items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <DashBoardIcon color={selectedSideBar === 0 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedSideBar === 0 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Dashboard
            </span>
          )}
        </div>

        {/* Orders */}
        <div
          onClick={(e) => {
            setSelectedSideBar(1);
            history.push("/orders");
          }}
          className={`flex w-${
            isSideBarOpen ? "48" : "42"
          }  items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <CartIcon color={selectedSideBar === 1 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedSideBar === 1 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Orders
            </span>
          )}
        </div>

        {/* Products */}
        <div
          onClick={(e) => {
            setSelectedSideBar(2);
            history.push("/products");
          }}
          className={`flex w-${
            isSideBarOpen ? "48" : "42"
          }  items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <BagIcon color={selectedSideBar === 2 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedSideBar === 2 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Products
            </span>
          )}
        </div>

        {/*Categories  */}

        <div
          onClick={(e) => {
            setSelectedSideBar(3);
            history.push("/categories");
          }}
          className={`flex w-${
            isSideBarOpen ? "48" : "42"
          }  items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <CategoryIcon color={selectedSideBar === 3 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedSideBar === 3 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Categories
            </span>
          )}
        </div>

        {/* Banners */}

        <div
          onClick={(e) => {
            setSelectedSideBar(4);
            history.push("/banners");
          }}
          className={`flex w-${
            isSideBarOpen ? "48" : "42"
          }  items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <BannerIcon color={selectedSideBar === 4 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedSideBar === 4 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Banners
            </span>
          )}
        </div>

        {/* Deals */}

        <div
          onClick={(e) => {
            setSelectedSideBar(5);
            history.push("/flashDeal");
          }}
          className={`flex w-${
            isSideBarOpen ? "48" : "42"
          }  items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <FlashIcon color={selectedSideBar === 5 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedSideBar === 5 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Flash deal
            </span>
          )}
        </div>

        {/* Customer */}

        <div
          onClick={(e) => {
            setSelectedSideBar(6);
            history.push("/customers");
          }}
          className={`flex w-${
            isSideBarOpen ? "48" : "42"
          }  items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <PersonIcon
            className={selectedSideBar === 6 ? "fill-yellow" : "fill-white"}
          />
          {isSideBarOpen && (
            <span
              className={`${
                selectedSideBar === 6 ? "text-customYellow-light" : "text-white"
              } ml-3 text-sm font-semibold tracking-wider`}
            >
              Customers
            </span>
          )}
        </div>

        {/* Customer Reviews */}

        <div
          onClick={(e) => {
            setSelectedSideBar(7);
            history.push("/reviews");
          }}
          className={`flex w-${isSideBarOpen ? "48" : "42"} items-center py-3 ${
            isSideBarOpen ? "px-6" : "px-3"
          } rounded-2xl hover:bg-lightGrey-light cursor-pointer transform hover:scale-90 transition duration-500 ease-in-out`}
        >
          <ChatIcon color={selectedSideBar === 7 ? "#EC981A" : "#fff"} />
          {isSideBarOpen && (
            <span
              className={`${
                selectedSideBar === 7 ? "text-customYellow-light" : "text-white"
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
