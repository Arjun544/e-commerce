import React, { useState, useEffect, useContext } from "react";
import { useParams, useHistory } from "react-router-dom";
import { useSnackbar } from "notistack";
import  { Puff } from "react-loader-spinner";
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
import { Breadcrumb, Breadcrumbs } from "react-rainbow-components";
import TableActions from "../orders/components/table_actions";
import moment from "moment";

const CustomerDetails = () => {
  const { isBigScreen } = useContext(AppContext);
  const params = useParams();
  const history = useHistory();
  const { enqueueSnackbar } = useSnackbar();
  const [user, setUser] = useState([]);
  const [customer, setCustomer] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const userId = params.id;

  useEffect(() => {
    const getData = async () => {
      try {
        setIsLoading(true);
        const userData = await getUserById(userId);
        const response = await getUserOrders(userId);
        setUser(userData.data.data);
        setCustomer(response.data.orderList);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);

        error.response.data.success === false &&
        error.response.data.msg === "User not found"
          ? enqueueSnackbar("No user found", {
              variant: "error",
              autoHideDuration: 2000,
            })
          : enqueueSnackbar("Something went wrong", {
              variant: "error",
              autoHideDuration: 2000,
            });
      }
    };
    getData();
  }, [enqueueSnackbar,userId]);

  const data = customer.map((item) => ({
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
      Cell: (props) => (
        <span
          onClick={(e) =>
            history.push(`/orders/view/${props.cell.row.original.order.id}`)
          }
          className="text-green-500 text-sm font-semibold cursor-pointer"
        >
          {props.cell.value}
        </span>
      ),
    },
    {
      Header: "Date",
      accessor: "date",
      Cell: (props) => (
        <span className="text-gray-500">
          {moment(props.cell.value).format("ll")}
        </span>
      ),
    },
    {
      Header: "Customer Name",
      accessor: "customerName",
    },
    {
      Header: "Payment",
      accessor: "payment",
      Cell: (props) => (
        <span
          className={`${
            props.cell.value === "Card" ? "text-green-500" : "text-red-500"
          } `}
        >
          {props.cell.value}
        </span>
      ),
    },
    {
      Header: "Amount",
      accessor: "total",
    },
    {
      Header: "Delivery",
      accessor: "deliveryType",
      Cell: (props) => (
        <span
          className={`${
            props.cell.value === "Free"
              ? "text-customYellow-light"
              : "text-green-500"
          } `}
        >
          {props.cell.value}
        </span>
      ),
    },
    {
      Header: "Pay Status",
      accessor: "paid",
      Cell: (props) => (
        <span
          className={`${
            props.cell.value === "Unpaid" ? "text-red-500" : "text-green-500"
          } `}
        >
          {props.cell.value}
        </span>
      ),
    },
    {
      Header: "Phone",
      accessor: "phone",
    },
    {
      Header: "Status",
      accessor: "status",
      Cell: (props) => (
        <span
          className={`${(() => {
            if (props.cell.value === "Completed") return "text-green-500";
            if (props.cell.value === "Pending")
              return "text-customYellow-light";
            if (props.cell.value === "Confirmed") return "text-green-500";
            if (props.cell.value === "Rejected") return "text-red-500";
            if (props.cell.value === "Delivered") return "text-green-500";
            if (props.cell.value === "Cancelled") return "text-red-500";
            else {
              return "text-gray-500";
            }
          })()}`}
        >
          {props.cell.value}
        </span>
      ),
    },
    {
      Header: "Actions",
      accessor: "order",
      Cell: (props) => <TableActions order={props.cell.value} />,
    },
  ];

  return (
    <div className="flex flex-col w-full h-full mt-30 overflow-y-auto overflow-x-hidden bg-white">
      <TopBar />
      <div className="flex ml-10 my-6">
        <Breadcrumbs>
          <Breadcrumb label="Customers" onClick={() => history.goBack()} />
          <Breadcrumb label="Customer Detail" />
        </Breadcrumbs>
      </div>
      {isLoading || user.length === 0 ? (
        <div className="flex w-full h-screen items-center justify-center bg-white">
          <Puff color="#00BFFF" height={50} width={50} />
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
              {user.profile ? (
                <img
                  className="h-12 w-12 mb-6 rounded-full object-cover"
                  src={user.profile}
                  alt=""
                />
              ) : (
                <img
                  className="h-12 w-12 mb-6 rounded-full object-cover"
                  src="https://schooloflanguages.sa.edu.au/wp-content/uploads/2017/11/placeholder-profile-sq.jpg"
                  alt=""
                />
              )}
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
          {customer.length !== 0 ? (
            <UserOrdersTable columns={columns} data={data} />
          ) : (
            <div className="flex items-center justify-center">
              <span className="text-gray-500 font-semibold my-4">
                No Orders yet
              </span>
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default CustomerDetails;
