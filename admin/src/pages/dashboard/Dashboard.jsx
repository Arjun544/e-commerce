import React, { useContext } from "react";
import { AppContext } from "../../App";
import CategoryDropDown from "../../components/CategoryDropDown";
import CartIcon from "../../components/icons/CartIcon";
import CustomersPaymentChart from "./components/CustomersPaymentChart";
import EarningChart from "./components/EarningChart";
import OverviewChart from "./components/OverviewChart";
import RightContainer from "./components/Right_Container";
import TopProductsTable from "./components/TopProductsTable";
import { AvatarCell } from "./components/TopProductsTable";

const Dashboard = () => {
  const { isBigScreen } = useContext(AppContext);
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
    <div className="flex  w-full h-full overflow-y-auto bg-white px-4">
      {/* DashBoard  */}
      <div className={`flex flex-col w-${isBigScreen ? "3/4" : "full"} mr-6`}>
        <div className="flex  justify-between">
          <div className="flex flex-col">
            <span className="text-black font-semibold text-xl">Dashboard</span>
            <span className="text-gray-300 font-semibold text-sm">
              Detailed information about yor store
            </span>
          </div>
          <CategoryDropDown />
        </div>

        {/* Orders stats */}

        <div
          className={`${
            isBigScreen
              ? "grid grid-flow-col grid-rows-1 gap-4"
              : "grid grid-flow-col grid-rows-2 gap-4"
          } px-6  w-full py-${
            isBigScreen ? "12" : "6"
          } flex- items-center rounded-3xl justify-around mt-6 bg-bgColor-light`}
        >
          <div className="flex items-center">
            <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-green-100 bg-opacity-40">
              <CartIcon color={"#6EE7B7"} />
            </div>
            <div className="flex flex-col item justify-center">
              <span className="text-Grey-dark font-bold text-sm">
                Orders Completed
              </span>
              <span className="text-green-500 font-semibold text-xl">24</span>
            </div>
          </div>
          <div className="flex items-center">
            <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-customYellow-light bg-opacity-20">
              <CartIcon color={"#EC981A"} />
            </div>
            <div className="flex flex-col item justify-center">
              <span className="text-Grey-dark font-bold text-sm">
                Orders Pending
              </span>
              <span className="text-customYellow-light font-semibold text-xl">
                24
              </span>
            </div>
          </div>
          <div className="flex items-center">
            <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-indigo-100 bg-opacity-40">
              <CartIcon color={"#A5B4FC"} />
            </div>
            <div className="flex flex-col item justify-center">
              <span className="text-Grey-dark font-bold text-sm">
                Orders Confirmed
              </span>
              <span className="text-indigo-500 font-semibold text-xl">24</span>
            </div>
          </div>
          <div className="flex items-center">
            <div className="flex h-14 w-14 items-center justify-center rounded-2xl mr-4 bg-red-100 bg-opacity-40">
              <CartIcon color={"#FCA5A5"} />
            </div>
            <div className="flex flex-col item justify-center">
              <span className="text-Grey-dark font-bold text-sm">
                Orders Out of Delivery
              </span>
              <span className="text-red-500 font-semibold text-xl">24</span>
            </div>
          </div>
        </div>

        {/*  */}
        <div className="flex flex-col mt-12">
          <EarningChart />
        </div>

        <div
          className={`flex ${
            !isBigScreen && "flex-col"
          } w-full justify-around mt-12`}
        >
          {/* Business Overview */}
          <div
            className={`h-full flex-grow ${
              isBigScreen ? "mr-6" : "mb-6"
            } bg-bgColor-light rounded-3xl p-6`}
          >
            <OverviewChart />
          </div>

          {/* Customer Payments*/}
          <div className="h-full flex-grow bg-bgColor-light rounded-3xl p-6">
            <CustomersPaymentChart />
          </div>
        </div>

        {/* Top Products */}
        <div className="flex flex-col h-full mt-12">
          <span className="text-black font-semibold text-xl">Top Products</span>
          <span className="text-gray-300 font-semibold text-sm">
            Best selling products in your store
          </span>

          <TopProductsTable columns={columns} data={data} />
        </div>
      </div>
      {isBigScreen && <RightContainer />}
    </div>
  );
};

export default Dashboard;
