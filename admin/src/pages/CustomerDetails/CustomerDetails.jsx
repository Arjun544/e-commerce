import React, { useState, useEffect, useContext } from "react";
import { useParams } from "react-router-dom";
import { useSnackbar } from "notistack";
import Loader from "react-loader-spinner";
import { getUserById } from "../../api/userApi";
import TopBar from "../../components/TopBar";
import PersonIcon from "../../components/icons/PersonIcon";
import MessageIcon from "../../components/icons/MessageIcon";
import LocationIcon from "../../components/icons/LocationIcon";
import HomeIcon from "../../components/icons/HomeIcon";
import WorkIcon from "../../components/icons/WorkIcon";
import { AppContext } from "../../App";
import { getUserOrders } from "../../api/ordersApi";
import UserOrdersTable from "./components/UserOrdersTable";
import ItemCard from "./components/ItemCard";

const CustomerDetails = () => {
  const { isBigScreen } = useContext(AppContext);
  const params = useParams();
  const { enqueueSnackbar, closeSnackbar } = useSnackbar();
  const [user, setUser] = useState([]);
  const [tableData, setTableData] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const userId = params.id;

  useEffect(() => {
    const getData = async () => {
      try {
        setIsLoading(true);
        const { data } = await getUserById(userId);
        const response = await getUserOrders(userId);
        setTableData(response.data);
        setUser(data.data);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
        console.log(error.response);
        enqueueSnackbar("Something went wrong", {
          variant: "error",
          autoHideDuration: 2000,
        });
      }
    };
    getData();
  }, []);

  const data = tableData.map((item) => ({
    order: item,
    amount: item.totalPrice,
    products: item.orderItems.length,
    date: item.dateOrdered,
    payment: item.payment,
    status: item.status,
    delivery: item.deliveryType,
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
      Header: "Date",
      accessor: "date",
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
      Header: "Payment",
      accessor: "payment",
    },
    {
      Header: "Status",
      accessor: "status",
    },
    {
      Header: "Products",
      accessor: "products",
      Cell: (props) => (
        <ItemCard
          value={props.cell.value}
          items={props.cell.row.original.order}
        />
      ),
    },
  ];

  return (
    <div className="flex flex-col w-full h-full mt-30 overflow-y-auto overflow-x-hidden bg-white">
      <TopBar />

      {isLoading || user.length === 0 ? (
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
        <div className="flex flex-col w-full h-full px-10 mt-4">
          <div className={`${isBigScreen ? "flex" : "flex-col"} h-1/4`}>
            {/* Left container */}
            <div
              className={`flex-col p-5 h-full ${
                isBigScreen ? "w-1/2 mr-6" : "w-full mb-6"
              } min-w-min rounded-3xl bg-bgColor-light  hover:shadow-sm`}
            >
              <img
                className="h-14 w-14 rounded-2xl object-cover mb-5"
                src={user.profile}
                alt=""
              />
              <div className="flex items-center mb-3">
                <PersonIcon className="fill-grey h-5 w-5 mr-2" />
                <span className="text-black font-semibold text-sm">
                  {user.username.charAt(0).toUpperCase() +
                    user.username.slice(1)}
                </span>
              </div>
              <div className="flex items-center mb-3">
                <MessageIcon className="fill-grey h-5 w-5 mr-2" />
                <span className="text-black font-semibold text-sm">
                  {user.email.charAt(0).toUpperCase() + user.email.slice(1)}
                </span>
              </div>
              <div className="flex items-center">
                <LocationIcon className="fill-grey h-5 w-5 mr-2" />
                <span className="text-black font-semibold text-sm">
                  {user.country === ""
                    ? "None"
                    : user.country.charAt(0).toUpperCase() +
                      user.country.slice(1)}
                </span>
              </div>
            </div>
            {/* Right Container */}
            <div className="flex flex-col h-full rounded-3xl w-full p-5 bg-bgColor-light hover:shadow-sm">
              <span className="text-black font-semibold">
                Shipping Addresses
              </span>
              {user.ShippingAddress.length === 0 ? (
                <div className="flex h-full items-center justify-center">
                  <span className="text-gray-500 font-semibold text-sm">
                    No addesses
                  </span>
                </div>
              ) : (
                user.ShippingAddress.map((address, index) => (
                  <div id={index} className="flex items-center mt-4">
                    <div className="flex items-center">
                      {address.type === "home" ? (
                        <HomeIcon className="fill-grey h-5 w-5 mr-2" />
                      ) : (
                        <WorkIcon className="fill-grey h-5 w-5 mr-2" />
                      )}
                      <span className="text-gray-500 font-semibold text-sm">
                        {address.address.charAt(0).toUpperCase() +
                          address.address.slice(1)}
                      </span>
                      <span className="text-gray-500 font-semibold text-sm">
                        ,{" "}
                        {address.city.charAt(0).toUpperCase() +
                          address.city.slice(1)}
                      </span>
                      <span className="text-gray-500 font-semibold text-sm">
                        ,{" "}
                        {address.country.charAt(0).toUpperCase() +
                          address.country.slice(1)}
                      </span>
                    </div>
                  </div>
                ))
              )}
            </div>
          </div>
          {/* Orders */}
          <span className="text-black font-semibold my-4">Orders</span>
          <UserOrdersTable columns={columns} data={data} />
        </div>
      )}
    </div>
  );
};

export default CustomerDetails;