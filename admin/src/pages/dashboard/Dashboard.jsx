import React, { useContext, useEffect, useState } from "react";
import { AppContext } from "../../App";

import CustomersPaymentChart from "./components/CustomersPaymentChart";
import EarningChart from "./components/EarningChart";
import OverviewChart from "./components/OverviewChart";
import OrdersMenu from "./components/Orders_Menu";
import TopProductsTable from "./components/TopProductsTable";
import { AvatarCell } from "./components/TopProductsTable";
import TopBar from "../../components/TopBar";
import AllOrders from "./components/AllOrders";
import LatestReviews from "./components/LatestReviews";
import CustomerReviews from "./components/CustomerReviews";
import ActivityOverview from "./components/ActivityOverview";
import TopCustomers from "./components/TopCustomers";
import OrderStats from "./components/OrderStats";
import { getOrders } from "../../api/ordersApi";
import { useDispatch, useSelector } from "react-redux";
import { setOrders } from "../../redux/reducers/ordersSlice";
import OrderStatsLoader from "../../components/loaders/OrderStatsLoader";

const Dashboard = () => {
  const { isBigScreen } = useContext(AppContext);
  const dispatch = useDispatch();
  const [isOrderMenuOpen, setIsOrderMenuOpen] = useState(false);
  const [isOrdersLoading, setIsOrdersLoading] = useState(false);

  useEffect(() => {
    const fetchOrders = async () => {
      try {
        setIsOrdersLoading(true);
        const { data } = await getOrders();
        dispatch(setOrders({ orders: data.orderList }));
        setIsOrdersLoading(false);
      } catch (error) {
        setIsOrdersLoading(false);
        console.log(error.response);
      }
    };
    fetchOrders();
  }, []);

  const onTodaysOrdersClick = (e) => {
    e.preventDefault();
    setIsOrderMenuOpen(true);
  };

  const data = [
    {
      name: "Jane Cooper",
      price: 27,
      dateAdded: Date.now(),
      rating: "2.5",
      imgUrl:
        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=4&w=256&h=256&q=60",
    },
    {
      name: "Jane Cooper",
      price: 27,
      dateAdded: Date.now(),
      rating: "2.5",
      imgUrl:
        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=4&w=256&h=256&q=60",
    },
    {
      name: "Jane Cooper",
      price: 27,
      rating: "2.5",
      dateAdded: Date.now(),
      imgUrl:
        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=4&w=256&h=256&q=60",
    },
  ];

  const columns = [
    {
      Header: "Name",
      accessor: "name",
      Cell: AvatarCell,
      imgAccessor: "imgUrl",
    },
    {
      Header: "Date added",
      accessor: "dateAdded",
    },
    {
      Header: "Price",
      accessor: "price",
    },
    {
      Header: "Rating",
      accessor: "rating",
    },
  ];

  return (
    <div className="flex flex-col w-full h-full overflow-y-auto bg-white scrollbar scrollbar-thin hover:scrollbar-thumb-gray-900 scrollbar-thumb-gray-500 scrollbar-track-gray-300">
      {isOrderMenuOpen && (
        <OrdersMenu
          isOrderMenuOpen={isOrderMenuOpen}
          setIsOrderMenuOpen={setIsOrderMenuOpen}
        />
      )}
      <TopBar />
      <div className="flex my-6 px-6">
        {/* DashBoard  */}
        <div className={`flex flex-col w-full mr-6`}>
          <div className="flex  justify-between">
            <div className="flex flex-col">
              <span className="text-black font-semibold text-xl tracking-wide">
                Dashboard
              </span>
              <span className="text-gray-300 font-semibold text-sm">
                Detailed information about yor store
              </span>
            </div>

            <div
              onClick={onTodaysOrdersClick}
              className="flex relative h-12 bg-darkBlue-light  shadow-sm border-none ml-4 w-40 rounded-xl hover:bg-Grey-dark items-center justify-center cursor-pointer"
            >
              <span className="font-semibold text-sm text-white">
                Today's Orders
              </span>
            </div>
          </div>
          {/* Orders stats */}
          {isOrdersLoading ? <OrderStatsLoader /> : <OrderStats />}
          {/*  */}
          <div className="flex mt-12">
            <div
              className={`h-full flex-grow ${
                isBigScreen ? "mr-6" : "mb-6"
              } bg-bgColor-light rounded-3xl p-6 shadow-sm`}
            >
              <EarningChart />
            </div>

            <div
              className={`flex h-full flex-grow-0 w-1/3 bg-bgColor-light rounded-3xl p-6 shadow-sm`}
            >
              <OverviewChart />
            </div>
          </div>
          <div
            className={`flex ${
              !isBigScreen && "flex-col"
            } w-full justify-around mt-12`}
          >
            {/* All Orders */}
            <div
              className={`flex-grow ${
                isBigScreen ? "mr-6" : "mb-6"
              } bg-bgColor-light rounded-3xl p-6 shadow-sm`}
            >
              <AllOrders />
            </div>
            <div
              className={`h-full flex-grow bg-bgColor-light rounded-3xl p-6 shadow-sm ${
                isBigScreen ? "mr-6" : "mb-6"
              }`}
            >
              <CustomerReviews />
            </div>
            {/* Latest Reviews*/}
            <div className="h-full w-1/3 bg-bgColor-light rounded-3xl p-6 shadow-sm">
              <LatestReviews />
            </div>
          </div>
          <div
            className={`flex ${
              !isBigScreen && "flex-col"
            } w-full justify-around mt-12`}
          >
            {/* Customer Payments*/}
            <div
              className={`h-full ${
                isBigScreen ? "mr-6" : "mb-6"
              } flex-grow bg-bgColor-light rounded-3xl p-6 shadow-sm`}
            >
              <CustomersPaymentChart />
            </div>
            {/* ActivityOverview */}
            <div className="h-full w-1/3 bg-bgColor-light rounded-3xl p-6 shadow-sm">
              <ActivityOverview />
            </div>
          </div>

          {/* Top Products */}
          <div className="flex mt-12">
            <div
              className={`h-full w-1/2 bg-bgColor-light rounded-3xl p-6 shadow-sm ${
                isBigScreen ? "mr-8" : "mb-6"
              }`}
            >
              <TopCustomers />
            </div>

            <div className="flex flex-col flex-grow h-full w-full bg-bgColor-light rounded-3xl p-6 shadow-sm">
              <TopProductsTable columns={columns} data={data} />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
