import React, { useState, useRef, useContext } from "react";
import { CheckIcon, DotsVerticalIcon, XIcon } from "@heroicons/react/solid";
import useOutsideClick from "../../../useOutsideClick";
import { updateStatus } from "../../../api/ordersApi";
import { AppContext } from "../../../App";

const TableActions = ({ order, setOrders }) => {
  const { isBigScreen, socket } = useContext(AppContext);
  const [isOpen, setIsOpen] = useState(false);
  const ref = useRef();

  useOutsideClick(ref, () => {
    if (isOpen) {
      setIsOpen(false);
    }
  });

  const handleAcceptOrder = async (e) => {
    e.preventDefault();
    // console.log(order);
    await updateStatus(order._id, "Confirmed", false, true);
    socket.current.on("update-orderStatus", (newOrder) => {
      setOrders(newOrder);
    });
  };

  const handleRejectOrder = async (e) => {
    e.preventDefault();
    await updateStatus(order._id, "Rejected", false, true);
    socket.current.on("update-orderStatus", (newOrder) => {
      setOrders(newOrder);
    });
  };

  return (
    <div
      ref={ref}
      onClick={(e) => setIsOpen((previousState) => !previousState)}
      className="flex-col"
    >
      <div className="flex items-center justify-center cursor-pointer hover:text-customYellow-light">
        <DotsVerticalIcon className="h-5" />
      </div>
      {isOpen && (
        <div className="flex flex-col absolute z-50 h-auto w-32 rounded-2xl mt-1 py-1 bg-white shadow-md">
          <div
            onClick={
              order.status === "Cancelled" ||
              order.status === "Completed" ||
              order.status === "Confirmed" ||
              order.status === "Processing" ||
              order.status === "Delivered"
                ? null
                : handleAcceptOrder
            }
            className={`flex justify-center items-center px-4 py-2 ${
              order.status === "Cancelled" ||
              order.status === "Completed" ||
              order.status === "Confirmed" ||
              order.status === "Processing" ||
              order.status === "Delivered"
                ? "cursor-not-allowed"
                : "cursor-pointer hover:bg-blue-light"
            }`}
          >
            <div className="flex items-center">
              <CheckIcon className="h-5 mr-2 text-green-500" />
              <span
                className={`${
                  order.status === "Cancelled" ||
                  order.status === "Completed" ||
                  order.status === "Confirmed" ||
                  order.status === "Processing" ||
                  order.status === "Delivered"
                    ? "text-gray-300"
                    : "text-green-500"
                } font-semibold text-base`}
              >
                Accept
              </span>
            </div>
          </div>

          <div
            onClick={
              order.status === "Cancelled" ||
              order.status === "Completed" ||
              order.status === "Rejected" ||
              order.status === "Delivered"
                ? null
                : handleRejectOrder
            }
            className={`flex justify-center items-center px-4 py-2 ${
              order.status === "Cancelled" ||
              order.status === "Completed" ||
              order.status === "Rejected" ||
              order.status === "Delivered"
                ? "cursor-not-allowed"
                : "cursor-pointer hover:bg-blue-light"
            }`}
          >
            <div className="flex items-center">
              <XIcon className="h-5 mr-2 text-red-500" />
              <span
                className={`${
                  order.status === "Cancelled" ||
                  order.status === "Completed" ||
                  order.status === "Rejected" ||
                  order.status === "Delivered"
                    ? "text-gray-300"
                    : "text-red-500"
                } font-semibold text-base`}
              >
                Reject
              </span>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default TableActions;
