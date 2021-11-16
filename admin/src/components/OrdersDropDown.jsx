import moment from "moment";
import { useState, useRef } from "react";
import useOutsideClick from "../useOutsideClick";
import ArrowDownIcon from "./icons/ArrowDownIcon";

const OrdersDropDown = ({orders, setFilteredOrders }) => {
  const [selectedCategory, setSelectedCategory] = useState("All");
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

  const handleSortAll = (e) => {
    e.preventDefault();
    setSelectedCategory("All");
    setFilteredOrders(orders);
  };

  const handleSortWeek = (e) => {
    e.preventDefault();
    setSelectedCategory("Weekly");
    setFilteredOrders(
      orders.filter((order) =>
        moment(new Date(new Date(order.dateOrdered).getTime())).isBetween(
          moment(new Date(new Date().getTime() - 168 * 60 * 60 * 1000))
        )
      )
    );
  };

  const handleSortMonth = (e) => {
    e.preventDefault();
    setSelectedCategory("Monthly");
     setFilteredOrders(
       orders.filter((order) =>
         moment(new Date(new Date(order.dateOrdered).getTime())).isBetween(
           moment(new Date(new Date().getTime() - 720 * 60 * 60 * 1000))
         )
       )
     );
  };

  return (
    <div
      ref={ref}
      onClick={toggleMenu}
      className={
        "flex relative h-12 bg-blue-light shadow-sm border-none px-4 w-40 rounded-xl hover:bg-blue-light hover:bg-opacity-70 items-center justify-between cursor-pointer"
      }
    >
      <span className="font-semibold text-sm text-black">
        {selectedCategory}
      </span>

      <ArrowDownIcon color={"#000000"} />
      {isOpen && (
        <div className="absolute top-14 z-40 left-0 right-1 h-30 w-40 flex flex-col py-4 px-2 rounded-2xl shadow bg-gray-50">
          <span className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:text-black hover:bg-blue-light">
            <div onClick={handleSortAll}>All</div>
          </span>
          <span className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:text-black hover:bg-blue-light">
            <div onClick={handleSortWeek}>Weekly</div>
          </span>
          <span className="font-semibold mb-1 pl-4 rounded-md text-gray-400 hover:text-black hover:bg-blue-light">
            <div onClick={handleSortMonth}>Monthly</div>
          </span>
        </div>
      )}
    </div>
  );
};

export default OrdersDropDown;
