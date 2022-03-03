import { useState, useRef, useContext } from "react";
import useOutsideClick from "../../../useOutsideClick";
import ArrowDownIcon from "../../../components/icons/ArrowDownIcon";
import { updateStatus } from "../../../api/ordersApi";
import { AppContext } from "../../../App";

const PaidDropDown = ({ order, setOrder }) => {
  const { socket } = useContext(AppContext);
  const [selectedStatus, setSelectedStatus] = useState(order.isPaid);
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

  const handleSortPaid = async (e) => {
    e.preventDefault();
    await updateStatus(order._id, "", true, false);
    socket.current.on("update-orderStatus", (newOrder) => {
      setOrder(newOrder);
      setSelectedStatus(newOrder.isPaid);
    });
  };

  const handleSortUnPaid = async (e) => {
    e.preventDefault();
    await updateStatus(order._id, "", false, false);
    socket.current.on("update-orderStatus", (newOrder) => {
      setOrder(newOrder);
      setSelectedStatus(newOrder.isPaid);
    });
  };

  return (
    <div
      ref={ref}
      onClick={toggleMenu}
      className={
        "flex relative h-10 bg-blue-light shadow-sm border-none px-3 mr-4 w-24 rounded-xl hover:bg-blue-light hover:bg-opacity-70 items-center justify-between cursor-pointer"
      }
    >
      <span className="font-semibold text-sm text-black">
        {selectedStatus ? "Paid" : "Unpaid"}
      </span>

      <ArrowDownIcon color={"#000000"} />
      {isOpen && (
        <div className="absolute top-12 z-40 left-0 right-1 h-30 w-24 flex flex-col py-2 px-2 rounded-2xl shadow bg-gray-50">
          <span className="font-semibold mb-1 pl-2 rounded-md text-gray-400 hover:text-black hover:bg-blue-light">
            <div onClick={handleSortPaid}>Paid</div>
          </span>
          <span className="font-semibold mb-1 pl-2 rounded-md text-gray-400 hover:text-black hover:bg-blue-light">
            <div onClick={handleSortUnPaid}>Unpaid</div>
          </span>
        </div>
      )}
    </div>
  );
};

export default PaidDropDown;
