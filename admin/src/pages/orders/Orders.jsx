import React, { useState, useContext } from "react";
import { AppContext } from "../../App";
import OrdersTable from "./components/orders_table";
import { TableActions } from "./components/table_actions";

const Orders = () => {
  const { isBigScreen } = useContext(AppContext);
  const [selectedTab, setSelectedTab] = useState(0);

  const data = [
    {
      order: "100798",
      date: Date.now(),
      customerName: "Test",
      payment: "Cash",
      status: "Pending",
      amount: 500,
      delivery: "Free",
    },
    {
      order: "100798",
      date: Date.now(),
      customerName: "Test",
      payment: "Cash",
      status: "Pending",
      amount: 500,
      delivery: "Express",
    },
    {
      order: "100798",
      date: Date.now(),
      customerName: "Test",
      payment: "Cash",
      status: "Pending",
      amount: 500,
      delivery: "Free",
    },
    {
      order: "100798",
      date: Date.now(),
      customerName: "Test",
      payment: "Cash",
      status: "Pending",
      amount: 500,
      delivery: "Free",
    },
    {
      order: "100798",
      date: Date.now(),
      customerName: "Test",
      payment: "Cash",
      status: "Cancelled",
      amount: 500,
      delivery: "Free",
    },
    {
      order: "100798",
      date: Date.now(),
      customerName: "Test",
      payment: "Cash",
      status: "Delivered",
      amount: 500,
      delivery: "Free",
    },
    {
      order: "100798",
      date: Date.now(),
      customerName: "Test",
      payment: "Card",
      status: "Confirmed",
      amount: 500,
      delivery: "Free",
    },
  ];

  const columns = [
    
    {
      Header: "No",
      maxWidth: 10,
      accessor: "",
      Cell: (row) => {
        console.log(row.row);
        return <div>{row.row.index +1}</div>;
      },
      disableSortBy: true,
      disableFilters: true,
    },
    {
      Header: "Order",
      accessor: "order",
    },
    {
      Header: "Date",
      accessor: "date",
    },
    {
      Header: "Customer Name",
      accessor: "customerName",
    },
    {
      Header: "Payment",
      accessor: "payment",
    },
    {
      Header: "Amount",
      accessor: "amount",
    },
    {
      Header: "Delivery",
      accessor: "delivery",
    },
    {
      Header: "Status",
      accessor: "status",
    },
    {
      Header: "Actions",
      Cell: TableActions,
    },
  ];

  return (
    <div className="flex flex-col h-full overflow-y-auto overflow-x-hidden  bg-white px-10">
      {/* Tabs */}

      <div className="flex items-center mb-6 w-full justify-center cursor-pointer pt-4">
        <div className="tabs tabs-boxed w-3/4 flex items-center justify-between h-16 rounded-3xl px-5 bg-bgColor-light">
          <a
            onClick={(e) => {
              e.preventDefault();
              setSelectedTab(0);
            }}
            className={
              selectedTab === 0
                ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-semibold  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-110 transition duration-500 ease-in-out"
                : "tabs w-28 h-10 items-center justify-center font-semibold text-gray-400 tracking-wide"
            }
          >
            All
          </a>
          <a
            onClick={(e) => {
              e.preventDefault();
              setSelectedTab(1);
            }}
            className={
              selectedTab === 1
                ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-semibold  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-110 transition duration-500 ease-in-out"
                : "tabs w-28 h-10 items-center justify-center font-semibold text-gray-400 tracking-wide"
            }
          >
            Completed
          </a>
          <a
            onClick={(e) => {
              e.preventDefault();
              setSelectedTab(2);
            }}
            className={
              selectedTab === 2
                ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-semibold text-white  tracking-wide bg-amber-light rounded-2xl transform hover:scale-110 transition duration-500 ease-in-out"
                : "tabs w-28 h-10 items-center justify-center font-semibold text-gray-400 tracking-wide"
            }
          >
            Pending
          </a>
          <a
            onClick={(e) => {
              e.preventDefault();
              setSelectedTab(3);
            }}
            className={
              selectedTab === 3
                ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-semibold  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-110 transition duration-500 ease-in-out"
                : "tabs w-28 h-10 items-center justify-center font-semibold text-gray-400 tracking-wide"
            }
          >
            Confirmed
          </a>
          <a
            onClick={(e) => {
              e.preventDefault();
              setSelectedTab(4);
            }}
            className={
              selectedTab === 4
                ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-semibold  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-110 transition duration-500 ease-in-out"
                : "tabs w-28 h-10 items-center justify-center font-semibold text-gray-400 tracking-wide"
            }
          >
            Processing
          </a>
          <a
            onClick={(e) => {
              e.preventDefault();
              setSelectedTab(5);
            }}
            className={
              selectedTab === 5
                ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-semibold  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-110 transition duration-500 ease-in-out"
                : "tabs w-28 h-10 items-center justify-center font-semibold text-gray-400 tracking-wide"
            }
          >
            Delivered
          </a>
        </div>
      </div>
      {/* Views */}
      <OrdersTable columns={columns} data={data} />
    </div>
  );
};

export default Orders;
