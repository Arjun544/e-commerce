import { XIcon } from "@heroicons/react/solid";
import React, { useRef, useContext } from "react";
import { useSelector } from "react-redux";
import useOutsideClick from "../../../useOutsideClick";
import { useHistory } from "react-router-dom";
import { AppContext } from "../../../App";
import moment from "moment";

const OrdersMenu = ({ isOrderMenuOpen, setIsOrderMenuOpen }) => {
  const { setSelectedSideBar } = useContext(AppContext);
  const history = useHistory();
  const { orders } = useSelector((state) => state.orders);
  const ref = useRef();

  useOutsideClick(ref, () => {
    if (isOrderMenuOpen) {
      setIsOrderMenuOpen(false);
    }
  });

  const onOrderClick = (e, id) => {
    e.preventDefault();
    setSelectedSideBar(1);
    history.push(`/orders/view/${id}`);
  };

  return (
    <div className="flex absolute z-40 right-0 w-full h-full backdrop-filter backdrop-blur-md">
      <div className="flex items-start absolute top-0 right-0 z-50 flex-col w-1/5 h-full px-5 pt-4 bg-bgColor-light ">
        <XIcon
          onClick={(e) => {
            e.preventDefault();
            setIsOrderMenuOpen(false);
          }}
          className="h-6 text-black mb-4 cursor-pointer"
        />
        {orders.filter((items) =>
          moment(new Date(new Date(items.dateOrdered).getTime())).isBetween(
            moment(new Date(new Date().getTime() - 24 * 60 * 60 * 1000))
          )
        ).length === 0 ? (
          <div className="h-full w-full flex items-center justify-center">
            <span className="font-bold tracking-wider text-gray-400">No Orders</span>
          </div>
        ) : (
          orders
            .filter((items) =>
              moment(new Date(new Date(items.dateOrdered).getTime())).isBetween(
                moment(new Date(new Date().getTime() - 24 * 60 * 60 * 1000))
              )
            )
            .map((order, index) => (
              <div
                key={index}
                onClick={(e) => onOrderClick(e, order._id)}
                className="flex items-center justify-between h-24 w-full mb-4 bg-white rounded-3xl px-4 shadow-sm cursor-pointer hover:shadow-md"
              >
                <div className="flex">
                  {order.user.profile ? (
                    <img
                      className="w-16 h-16 rounded-2xl mr-3  object-cover"
                      src={order.user.profile}
                      alt=""
                    />
                  ) : (
                    <img
                      className="w-16 h-16 rounded-2xl mr-3  object-cover"
                      src="https://schooloflanguages.sa.edu.au/wp-content/uploads/2017/11/placeholder-profile-sq.jpg"
                      alt=""
                    />
                  )}

                  <div className="flex flex-col justify-center">
                    <span className="text-black font-semibold">
                      {order.user.username.charAt(0).toUpperCase() +
                        order.user.username.slice(1)}
                    </span>
                    <div className="flex">
                      <span className="text-Grey-dark font-semibold mr-2">
                        items:
                      </span>
                      <span className="text-black font-semibold">
                        {order.orderItems.length}
                      </span>
                    </div>
                  </div>
                </div>
                <div className="flex flex-col items-end">
                  <span className="text-Grey-dark font-semibold mr-2">
                    ${order.totalPrice}
                  </span>
                  <span
                    className={`font-semibold ${(() => {
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
                    })()}`}
                  >
                    {order.status}
                  </span>
                </div>
              </div>
            ))
        )}
      </div>
    </div>
  );
};

export default OrdersMenu;
