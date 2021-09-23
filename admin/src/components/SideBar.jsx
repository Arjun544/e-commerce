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

  const { isSideBarOpen, isBigScreen, isMenuOpen, setIsMenuOpen } =
    useContext(AppContext);
  const [selectedBar, setSelectedBar] = useState(0);
  

  useEffect(() => {
    switch (createHistory.location.pathname) {
      case "/":
        setSelectedBar(0);
        break;
      case "/orders":
        setSelectedBar(1);
        break;
      case "/products":
        setSelectedBar(2);
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
            setSelectedBar(0);
            history.push("/");
          }}
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
          onClick={(e) => {
            setSelectedBar(1);
            history.push("/orders");
          }}
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
          onClick={(e) => {
            setSelectedBar(2);
            history.push("/products");
          }}
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
