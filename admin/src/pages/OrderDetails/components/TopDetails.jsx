import React, { useContext } from "react";
import InvoiceIcon from "../../../components/icons/InvoiceIcon";
import PaidDropDown from "./PaidDropDown";
import StatusDropDown from "./StatusDropDown";
import moment from "moment";
import { CalendarIcon } from "@heroicons/react/solid";
import { CheckIcon, XIcon } from "@heroicons/react/solid";
import StatusButon from "./StatusButton";
import { AppContext } from "../../../App";
import { updateStatus } from "../../../api/ordersApi";

const TopDetails = ({ order, setOrder }) => {
  const { isBigScreen, socket } = useContext(AppContext);

  const handleAcceptOrder = async (e) => {
    e.preventDefault();
    await updateStatus(order._id, "Confirmed", false, false);
    socket.current.on("update-orderStatus", (newOrder) => {
      setOrder(newOrder);
    });
  };

  const handleRejectOrder = async (e) => {
    e.preventDefault();
    await updateStatus(order._id, "Rejected", false, false);
    socket.current.on("update-orderStatus", (newOrder) => {
      setOrder(newOrder);
    });
  };

  return (
    <div className="flex flex-col bg-bgColor-light mb-10 p-6 rounded-3xl">
      <div
        className={`${
          isBigScreen ? "flex items-center" : "flex flex-col items-start"
        }`}
      >
        <span
          className={`text-black font-semibold tracking-wider text-lg ${
            !isBigScreen && "mb-3"
          }`}
        >
          Order #{order._id}
        </span>
        <div className="flex items-center">
          <div
            className={`flex h-6 w-20 rounded-md ${
              order.isPaid === true ? "bg-green-100" : "bg-red-100"
            } ${isBigScreen ? "ml-3" : "mb-3"} items-center justify-center`}
          >
            <div
              className={`h-2 w-2 mr-2 rounded-full ${
                order.isPaid === true ? "bg-green-500" : "bg-red-600"
              }`}
            ></div>
            <span
              className={`${
                order.isPaid === true ? "text-green-500" : "text-red-600"
              } font-semibold tracking-wider text-xs`}
            >
              {(() => {
                switch (order.isPaid) {
                  case true:
                    return "Paid";
                  case false:
                    return "Unpaid";
                  default:
                    break;
                }
              })()}
            </span>
          </div>
          <div
            className={`flex h-6 ml-3 px-2 rounded-md ${(() => {
              switch (order.status) {
                case "Completed":
                  return "bg-green-100";
                case "Pending":
                  return "bg-customYellow-light bg-opacity-30";
                case "Confirmed":
                  return "bg-indigo-100 bg-opacity-40";
                case "Rejected":
                  return "bg-red-200 bg-opacity-40";
                case "Processing":
                  return "bg-gray-300 bg-opacity-40";
                case "Delivered":
                  return "bg-green-100 bg-opacity-40";
                case "Cancelled":
                  return "bg-red-100 bg-opacity-40";
                default:
                  break;
              }
            })()} ${!isBigScreen && "mb-3"}  items-center justify-center`}
          >
            <div
              className={`h-2 w-2 mr-2 rounded-full ${(() => {
                switch (order.status) {
                  case "Completed":
                    return "bg-green-500";
                  case "Pending":
                    return "bg-customYellow-light";
                  case "Confirmed":
                    return "bg-indigo-500";
                  case "Rejected":
                    return "bg-red-500";
                  case "Processing":
                    return "bg-gray-500";
                  case "Delivered":
                    return "bg-green-500";
                  case "Cancelled":
                    return "bg-red-500";
                  default:
                    break;
                }
              })()}`}
            ></div>
            <span
              className={`${(() => {
                switch (order.status) {
                  case "Completed":
                    return "text-green-500";
                  case "Pending":
                    return "text-customYellow-light";
                  case "Confirmed":
                    return "text-indigo-500";
                  case "Rejected":
                    return "text-red-500";
                  case "Processing":
                    return "text-gray-500";
                  case "Delivered":
                    return "text-green-500";
                  case "Cancelled":
                    return "text-red-500";
                  default:
                    break;
                }
              })()} font-semibold tracking-wider text-xs`}
            >
              {order.status}
            </span>
          </div>
        </div>
        <div
          className={`flex items-center justify-center ${
            isBigScreen && "ml-3"
          }`}
        >
          <CalendarIcon className="h-5 fill-grey mr-2" />
          <span className="text-gray-500 font-semibold text-sm">
            {moment(order.dateOrdered).format("MMMM Do YYYY hh:mm")}
          </span>
        </div>
      </div>
      <div
        className={`${
          isBigScreen ? "flex items-center justify-between" : "flex flex-col"
        } `}
      >
        {/* Print invoice Button */}
        <div
          className={`flex w-36 p-2 rounded-xl items-center mt-1 cursor-pointer hover:bg-green-100 ${
            !isBigScreen && "mt-2 mb-2"
          }`}
        >
          <InvoiceIcon className="h-6 w-6 fill-lightGreen mr-2" />
          <span className="text-black font-semibold">Print Invoice</span>
        </div>
        {/* Order Status */}
        {order.status === "Pending" ? (
          <div className="flex">
            <StatusButon
              text={"Accept"}
              color={"bg-green-500"}
              icon={<CheckIcon className="h-5 mr-2 text-white" />}
              onPressed={handleAcceptOrder}
            />
            <StatusButon
              text={"Reject"}
              color={"bg-red-500"}
              icon={<XIcon className="h-5 mr-2 text-white" />}
              onPressed={handleRejectOrder}
            />
          </div>
        ) : (
          <div className="flex">
            <PaidDropDown order={order} setOrder={setOrder} />
            <StatusDropDown order={order} setOrder={setOrder} />
          </div>
        )}
      </div>
    </div>
  );
};

export default TopDetails;
