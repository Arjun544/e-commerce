import React, { useState, useContext, useEffect } from "react";
import { AppContext } from "../../App";
import OrdersTable from "./components/orders_table";
import TableActions from "./components/table_actions";
import TopBar from "../../components/TopBar";
import Loader from "react-loader-spinner";
import { getOrders } from "../../api/ordersApi";

const Orders = () => {
  const [isLoading, setIsLoading] = useState(false);
  const [currentPage, setCurrentPage] = useState(1);
  const [selectedOrdersTab, setSelectedOrdersTab] = useState(0);
  const [orders, setOrders] = useState({});

  useEffect(() => {
    const fetchOrders = async () => {
      try {
        setIsLoading(true);
        const { data } = await getOrders(currentPage, 10, true);
        setOrders(data);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
      }
    };
    fetchOrders();
  }, [currentPage]);

  const data =
    !isLoading &&
    orders.results !== undefined &&
    orders?.results.map((item) => ({
      order: item,
      id: item.id,
      date: item.dateOrdered,
      customerName: item.user.username,
      total: item.totalPrice,
      status: item.status,
      payment: item.payment,
      paid: item.isPaid ? "Paid" : "Unpaid",
      deliveryType: item.deliveryType,
      phone: item.phone,
      orderItems: item.orderItems.length,
    }));

  const columns = [
    {
      Header: "No",
      maxWidth: 10,
      accessor: "",
      Cell: (row) => {
        return <div>{row.row.index + 1}</div>;
      },
      disableSortBy: true,
      disableFilters: true,
    },
    {
      Header: "Id",
      accessor: "id",
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
      Header: "Pay Status",
      accessor: "paid",
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
      accessor: "order",
      Cell: (props) => (
        <TableActions  order={props.cell.value} />
      ),
    },
  ];

  return (
    <div className="flex flex-col w-full h-full overflow-y-auto overflow-x-hidden  bg-white">
      <TopBar />
      {isLoading ? (
        <div className="flex w-full h-screen items-center justify-center bg-white">
          <Loader
            type="Puff"
            color="#00BFFF"
            height={50}
            width={50}
            timeout={3000} //3 secs
          />
        </div>
      ) : (
        <div className="flex flex-col px-10">
          {/* Tabs */}
          <div className="flex items-center mb-6 w-full justify-center cursor-pointer pt-4">
            <div className="tabs tabs-boxed w-10/12 flex items-center justify-between h-16 rounded-3xl px-5 bg-bgColor-light">
              <a
                onClick={(e) => {
                  e.preventDefault();
                  setSelectedOrdersTab(0);
                }}
                className={
                  selectedOrdersTab === 0
                    ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-medium  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
                    : "tabs w-28 h-10 items-center justify-center font-medium text-gray-400 tracking-wide"
                }
              >
                All
              </a>
              <a
                onClick={(e) => {
                  e.preventDefault();
                  setSelectedOrdersTab(1);
                }}
                className={
                  selectedOrdersTab === 1
                    ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-medium  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
                    : "tabs w-28 h-10 items-center justify-center font-medium text-gray-400 tracking-wide"
                }
              >
                Completed
              </a>
              <a
                onClick={(e) => {
                  e.preventDefault();
                  setSelectedOrdersTab(2);
                }}
                className={
                  selectedOrdersTab === 2
                    ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-medium  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
                    : "tabs w-28 h-10 items-center justify-center font-medium text-gray-400 tracking-wide"
                }
              >
                Confirmed
              </a>
              <a
                onClick={(e) => {
                  e.preventDefault();
                  setSelectedOrdersTab(3);
                }}
                className={
                  selectedOrdersTab === 3
                    ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-medium  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
                    : "tabs w-28 h-10 items-center justify-center font-medium text-gray-400 tracking-wide"
                }
              >
                Rejected
              </a>
              <a
                onClick={(e) => {
                  e.preventDefault();
                  setSelectedOrdersTab(4);
                }}
                className={
                  selectedOrdersTab === 4
                    ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-medium  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
                    : "tabs w-28 h-10 items-center justify-center font-medium text-gray-400 tracking-wide"
                }
              >
                Pending
              </a>
              <a
                onClick={(e) => {
                  e.preventDefault();
                  setSelectedOrdersTab(5);
                }}
                className={
                  selectedOrdersTab === 5
                    ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-medium text-white  tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
                    : "tabs w-28 h-10 items-center justify-center font-medium text-gray-400 tracking-wide"
                }
              >
                Processing
              </a>

              <a
                onClick={(e) => {
                  e.preventDefault();
                  setSelectedOrdersTab(6);
                }}
                className={
                  selectedOrdersTab === 6
                    ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-medium  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
                    : "tabs w-28 h-10 items-center justify-center font-medium text-gray-400 tracking-wide"
                }
              >
                Delivered
              </a>

              <a
                onClick={(e) => {
                  e.preventDefault();
                  setSelectedOrdersTab(7);
                }}
                className={
                  selectedOrdersTab === 7
                    ? "tabs tab-active w-28 h-10 items-center bg-customYellow-light justify-center font-medium  text-white tracking-wide bg-amber-light rounded-2xl transform hover:scale-95 transition duration-500 ease-in-out"
                    : "tabs w-28 h-10 items-center justify-center font-medium text-gray-400 tracking-wide"
                }
              >
                Cancelled
              </a>
            </div>
          </div>

          {/* Views */}
          {!isLoading && orders.results !== undefined && (
            <OrdersTable
              columns={columns}
              setCurrentPage={setCurrentPage}
              currentPage={currentPage}
              totalPages={orders.total_pages}
              hasNextPage={orders.hasNextPage}
              hasPrevPage={orders.hasPrevPage}
              data={(() => {
                switch (selectedOrdersTab) {
                  case 0:
                    return data;
                  case 1:
                    return data.filter((item) => item.status === "Completed");
                  case 2:
                    return data.filter((item) => item.status === "Confirmed");
                  case 3:
                    return data.filter((item) => item.status === "Rejected");
                  case 4:
                    return data.filter((item) => item.status === "Pending");
                  case 5:
                    return data.filter((item) => item.status === "Procesing");
                  case 6:
                    return data.filter((item) => item.status === "Delivered");
                  case 7:
                    return data.filter((item) => item.status === "Cancelled");
                  default:
                    return;
                }
              })()}
            />
          )}
        </div>
      )}
    </div>
  );
};

export default Orders;
