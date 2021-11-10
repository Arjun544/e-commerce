import React, { useState, useContext, useEffect } from "react";
import { AppContext } from "../../App";
import OrdersTable from "./components/orders_table";
import TableActions from "./components/table_actions";
import TopBar from "../../components/TopBar";
import { getOrders } from "../../api/ordersApi";

const Orders = () => {
  const { isBigScreen } = useContext(AppContext);
  const [isLoading, setIsLoading] = useState(false);
  const [tableData, setTableData] = useState([]);
  const [selectedTab, setSelectedTab] = useState(0);

  useEffect(() => {
    const fetchOrders = async () => {
      try {
        setIsLoading(true);
        const { data } = await getOrders();
        setTableData(data.orderList);
        console.log(data.orderList);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
      }
    };
    fetchOrders();
  }, []);

  const data = tableData.map((item) => ({
    order: item,
    date: item.dateOrdered,
    customerName: item.user.username,
    total: item.totalPrice,
    status: item.status,
    payment: item.payment,
    country: item.country,
    deliveryType: item.deliveryType,
    phone: item.phone,
    orderItems: item.orderItems,
  }));

  const columns = [
    {
      Header: "No",
      maxWidth: 10,
      accessor: "",
      Cell: (row) => {
        console.log(row.row);
        return <div>{row.row.index + 1}</div>;
      },
      disableSortBy: true,
      disableFilters: true,
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
      accessor: "total",
    },
    {
      Header: "Delivery",
      accessor: "deliveryType",
    },
    {
      Header: "Phone",
      accessor: "phone",
    },
    {
      Header: "Status",
      accessor: "status",
    },
    {
      Header: "Actions",
      Cell: (props) => <TableActions value={props.cell.value} />,
    },
  ];

  return (
    <div className="flex flex-col w-full h-full overflow-y-auto overflow-x-hidden  bg-white">
      <TopBar />
      <div className="flex flex-col px-10">
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
                  ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-semibold  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
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
                  ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-semibold  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
                  : "tabs w-28 h-10 items-center justify-center font-semibold text-gray-400 tracking-wide"
              }
            >
              Pending
            </a>
            <a
              onClick={(e) => {
                e.preventDefault();
                setSelectedTab(2);
              }}
              className={
                selectedTab === 2
                  ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-semibold text-white  tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
                  : "tabs w-28 h-10 items-center justify-center font-semibold text-gray-400 tracking-wide"
              }
            >
              Processing
            </a>

            <a
              onClick={(e) => {
                e.preventDefault();
                setSelectedTab(3);
              }}
              className={
                selectedTab === 3
                  ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-semibold  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
                  : "tabs w-28 h-10 items-center justify-center font-semibold text-gray-400 tracking-wide"
              }
            >
              Delivered
            </a>
            <a
              onClick={(e) => {
                e.preventDefault();
                setSelectedTab(4);
              }}
              className={
                selectedTab === 4
                  ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-semibold  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
                  : "tabs w-28 h-10 items-center justify-center font-semibold text-gray-400 tracking-wide"
              }
            >
              Completed
            </a>
          </div>
        </div>
        {/* Views */}
        <OrdersTable
          columns={columns}
          data={(() => {
            switch (selectedTab) {
              case 0:
                return data;
              case 1:
                return data.filter((item) => item.status === "Pending");
              case 2:
                return data.filter((item) => item.status === "Processing");
              case 3:
                return data.filter(
                  (item) => item.status === "Out for delivery"
                );
              case 4:
                return data.filter((item) => item.status === "Completed");

              default:
                return;
            }
          })()}
        />
      </div>
    </div>
  );
};

export default Orders;
