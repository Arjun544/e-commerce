import moment from "moment";
import { useState, useRef, useContext } from "react";
import useOutsideClick from "../../../useOutsideClick";
import ArrowDownIcon from "../../../components/icons/ArrowDownIcon";
import { updateStatus } from "../../../api/ordersApi";
import { AppContext } from "../../../App";

const StatusDropDown = ({ order, setOrder }) => {
  const { socket } = useContext(AppContext);
  const [selectedStatus, setSelectedStatus] = useState(order.status);
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

  const handleSortCompleted = async (e) => {
    e.preventDefault();
    await updateStatus(order._id, "Completed", false, false);
    socket.current.on("update-orderStatus", (newOrder) => {
      setOrder(newOrder);
      setSelectedStatus(newOrder.status);
    });
  };

  const handleSortPending = async (e) => {
    e.preventDefault();
    setSelectedStatus("Pending");
    await updateStatus(order._id, "Pending", false, false);
    socket.current.on("update-orderStatus", (newOrder) => {
      setOrder(newOrder);
      setSelectedStatus(newOrder.status);
    });
  };

  const handleSortProcessing = async (e) => {
    e.preventDefault();
    setSelectedStatus("Processing");
    await updateStatus(order._id, "Processing", false, false);
    socket.current.on("update-orderStatus", (newOrder) => {
      setOrder(newOrder);
      setSelectedStatus(newOrder.status);
    });
  };

  const handleSortDelivered = async (e) => {
    e.preventDefault();
    setSelectedStatus("Delivered");
    await updateStatus(order._id, "Delivered", false, false);
    socket.current.on("update-orderStatus", (newOrder) => {
      setOrder(newOrder);
      setSelectedStatus(newOrder.status);
    });
  };

  const handleSortCancelled = async (e) => {
    e.preventDefault();
    setSelectedStatus("Cancelled");
    await updateStatus(order._id, "Cancelled", false, false);
    socket.current.on("update-orderStatus", (newOrder) => {
      setOrder(newOrder);
      setSelectedStatus(newOrder.status);
    });
  };

  return (
    <div
      ref={ref}
      onClick={toggleMenu}
      className={
        "flex relative h-10 bg-blue-light shadow-sm border-none px-4 w-40 rounded-xl hover:bg-blue-light hover:bg-opacity-70 items-center justify-between cursor-pointer"
      }
    >
      <span className="font-semibold text-sm text-black">{selectedStatus}</span>

      <ArrowDownIcon color={"#000000"} />
      {isOpen && (
        <div className="absolute top-12 z-40 left-0 right-1 h-30 w-40 flex flex-col py-2 px-2 rounded-2xl shadow bg-gray-50">
          <span className="font-semibold mb-1 pl-2 rounded-md text-gray-400 hover:text-black hover:bg-blue-light">
            <div onClick={handleSortCompleted}>Completed</div>
          </span>
          <span className="font-semibold mb-1 pl-2 rounded-md text-gray-400 hover:text-black hover:bg-blue-light">
            <div onClick={handleSortPending}>Pending</div>
          </span>
          <span className="font-semibold mb-1 pl-2 rounded-md text-gray-400 hover:text-black hover:bg-blue-light">
            <div onClick={handleSortProcessing}>Processing</div>
          </span>
          <span className="font-semibold mb-1 pl-2 rounded-md text-gray-400 hover:text-black hover:bg-blue-light">
            <div onClick={handleSortDelivered}>Delivered</div>
          </span>
          <span className="font-semibold mb-1 pl-2 rounded-md text-gray-400 hover:text-black hover:bg-blue-light">
            <div onClick={handleSortCancelled}>Cancelled</div>
          </span>
        </div>
      )}
    </div>
  );
};

export default StatusDropDown;
