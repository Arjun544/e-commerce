import React, { useState, useContext, useEffect } from "react";
import { AppContext } from "../../../App";
import OrdersDropDown from "../../../components/OrdersDropDown";
import CartIcon from "../../../components/icons/CartIcon";
import { useSelector } from "react-redux";
import InvoiceIcon from "../../../components/icons/InvoiceIcon";
import PaperDownIcon from "../../../components/icons/PaperDownIcon";
import DeliveredIcon from "../../../components/icons/DeliveredIcon";
import TimeIcon from "../../../components/icons/TimeIcon";
import DeclinedIcon from "../../../components/icons/DeclinedIcon";
import CancelIcon from "../../../components/icons/CancelIcon";
import { useHistory } from "react-router-dom";

const OrderStats = () => {
  const history = useHistory();
  const { isBigScreen, setSelectedSideBar } =
    useContext(AppContext);
  const { orders } = useSelector((state) => state.orders);
  const [filteredOrders, setFilteredOrders] = useState([]);

  useEffect(() => {
    setFilteredOrders(orders);
  }, []);
  return (
    <div
      className={
        "grid grid-flow-col grid-rows-1 gap-4 px-6 w-full py-4 rounded-3xl mt-6 bg-bgColor-light"
      }
    >
      <div className="flex flex-col">
        <div className="flex justify-between items-center mb-6">
          <span className="text-black font-semibold text-base tracking-wider">
            Orders Stats
          </span>
          <OrdersDropDown
            orders={orders}
            filteredOrders={filteredOrders}
            setFilteredOrders={setFilteredOrders}
          />
        </div>

        <div
          className={`${
            isBigScreen
              ? "flex justify-between mb-4 mr-4"
              : "grid grid-flow-col grid-rows-4 gap-4"
          }`}
        >
          {/*  Completed */}
          <div
            onClick={() => history.push("/orders")}
            className="flex items-center cursor-pointer"
          >
            <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-green-100 bg-opacity-40">
              <InvoiceIcon className="fill-lightGreen" />
            </div>
            <div className="flex flex-col item justify-center">
              <span className="text-Grey-dark font-bold text-sm">
                Completed
              </span>
              <span className="text-green-500 font-semibold text-xl">
                {
                  filteredOrders.filter((order) => order.status === "Completed")
                    .length
                }
              </span>
            </div>
          </div>
          {/* Pending */}
          <div
            onClick={() => {
              history.push("/orders");
              setSelectedSideBar(1);
            }}
            className="flex items-center cursor-pointer"
          >
            <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-customYellow-light bg-opacity-20">
              <PaperDownIcon className="fill-yellow h-8 w-8" />
            </div>
            <div className="flex flex-col item justify-center">
              <span className="text-Grey-dark font-bold text-sm">Pending</span>
              <span className="text-customYellow-light font-semibold text-xl">
                {
                  filteredOrders.filter((order) => order.status === "Pending")
                    .length
                }
              </span>
            </div>
          </div>
          {/* Confirmed */}
          <div
            onClick={() => {
              history.push("/orders");
              setSelectedSideBar(1);
            }}
            className="flex items-center cursor-pointer"
          >
            <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-indigo-100 bg-opacity-40">
              <CartIcon color={"#738aff"} />
            </div>
            <div className="flex flex-col item justify-center">
              <span className="text-Grey-dark font-bold text-sm">
                Confirmed
              </span>
              <span className="text-indigo-500 font-semibold text-xl">
                {
                  filteredOrders.filter((order) => order.status === "Confirmed")
                    .length
                }
              </span>
            </div>
          </div>
          {/* Rejected */}
          <div
            onClick={() => {
              history.push("/orders");
              setSelectedSideBar(1);
            }}
            className="flex items-center cursor-pointer"
          >
            <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-red-100 bg-opacity-40">
              <DeclinedIcon className="fill-lightRed h-8 w-8" />
            </div>
            <div className="flex flex-col item justify-center">
              <span className="text-Grey-dark font-bold text-sm">Rejected</span>
              <span className="text-red-500 font-semibold text-xl">
                {
                  filteredOrders.filter((order) => order.status === "Rejected")
                    .length
                }
              </span>
            </div>
          </div>
          {/*Processing  */}
          <div
            onClick={() => {
              history.push("/orders");
              setSelectedSideBar(1);
            }}
            className="flex items-center cursor-pointer"
          >
            <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-gray-300 bg-opacity-40">
              <TimeIcon className="fill-grey h-8 w-8" />
            </div>
            <div className="flex flex-col item justify-center">
              <span className="text-Grey-dark font-bold text-sm">
                Processing
              </span>
              <span className="text-Grey-dark font-semibold text-xl">
                {
                  filteredOrders.filter(
                    (order) => order.status === "Processing"
                  ).length
                }
              </span>
            </div>
          </div>
          {/* Delivered */}
          <div
            onClick={() => {
              history.push("/orders");
              setSelectedSideBar(1);
            }}
            className="flex items-center cursor-pointer"
          >
            <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-green-100 bg-opacity-40">
              <DeliveredIcon className="fill-lightGreen h-8 w-8" />
            </div>
            <div className="flex flex-col item justify-center">
              <span className="text-Grey-dark font-bold text-sm">
                Delivered
              </span>
              <span className="text-green-500 font-semibold text-xl">
                {
                  filteredOrders.filter((order) => order.status === "Delivered")
                    .length
                }
              </span>
            </div>
          </div>
          {/* Cancelled */}
          <div
            onClick={() => {
              history.push("/orders");
              setSelectedSideBar(1);
            }}
            className="flex items-center cursor-pointer"
          >
            <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-red-100 bg-opacity-40">
              <CancelIcon className="fill-lightRed h-8 w-8" />
            </div>
            <div className="flex flex-col item justify-center">
              <span className="text-Grey-dark font-bold text-sm">
                Cancelled
              </span>
              <span className="text-red-500 font-semibold text-xl">
                {
                  filteredOrders.filter((order) => order.status === "Cancelled")
                    .length
                }
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default OrderStats;
