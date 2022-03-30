import React, { useEffect, useState, useContext } from "react";
import { useParams, useHistory } from "react-router-dom";
import { getOrderById } from "../../api/ordersApi";
import TopBar from "../../components/TopBar";
import Lottie from "lottie-react";
import empty from "../../assets/images/empty";
import Loader from "react-loader-spinner";
import TopDetails from "./components/TopDetails";
import { Breadcrumb, Breadcrumbs } from "react-rainbow-components";
import { AppContext } from "../../App";
import moment from "moment";

const OrderDetails = () => {
  const { isBigScreen } = useContext(AppContext);
  const history = useHistory();
  const params = useParams();
  const orderId = params.id;
  const [isLoading, setIsLoading] = useState(false);
  const [order, setOrder] = useState([]);

  useEffect(() => {
    const getOrder = async () => {
      try {
        setIsLoading(true);
        const { data } = await getOrderById(orderId);
        setOrder(data.orderList);
        setIsLoading(false);
      } catch (error) {
        setIsLoading(false);
      }
    };
    getOrder();
  }, []);

  return (
    <div className="flex flex-col w-full h-full mt-30 overflow-y-auto overflow-x-hidden bg-white">
      <TopBar />
      <div className="flex ml-10 my-6">
        <Breadcrumbs>
          <Breadcrumb label="Orders" onClick={() => history.push("/orders")} />
          <Breadcrumb label="Order Detail" />
        </Breadcrumbs>
      </div>
      {isLoading ? (
        <div className="flex w-full h-screen items-center justify-center bg-white">
          <Loader type="Puff" color="#00BFFF" height={50} width={50} />
        </div>
      ) : order === undefined || order.length === 0 ? (
        <div className="flex flex-col items-center justify-center m-auto">
          <Lottie className="h-40" animationData={empty} />
          <span className="font-bold text-gray-300">No order found</span>
        </div>
      ) : (
        <div className="flex h-full flex-col px-8 mb-10 bg-white">
          {/* Order Top Details */}
          <TopDetails order={order} setOrder={setOrder} />
          {/* Order items detail */}
          <div
            className={`${isBigScreen ? "flex" : "flex flex-col"} flex-grow`}
          >
            {/* Items */}
            <div
              className={`flex flex-col flex-grow bg-bgColor-light ${
                isBigScreen ? "mr-10" : "mr-0"
              } p-6 rounded-3xl`}
            >
              <span className="font-semibold text-black mb-4">
                Items Summary
              </span>
              {order?.orderItems.map((product, i) => (
                <div
                  key={i}
                  className="flex h-16 items-center bg-white mb-4 border-none px-4 rounded-2xl shadow-sm justify-between justify-items-center hover:shadow-md"
                >
                  <div className="flex items-center justify-between w-full">
                    <img
                      className="h-10 w-10 rounded-2xl mr-6 ml-4 object-contain"
                      src={product.thumbnail}
                      alt=""
                    />
                    <span className="font-medium text-black overflow-hidden truncate w-full">
                      {product.name.charAt(0).toUpperCase() +
                        product.name.slice(1)}
                    </span>
                    <span className="font-medium text-black overflow-hidden truncate w-full">
                      x{product.quantity}
                    </span>
                    <span className="font-medium text-black overflow-hidden truncate w-full">
                      ${product.totalPrice}
                    </span>
                  </div>
                </div>
              ))}
            </div>
            {/* Right Container */}
            <div
              className={`flex flex-col ${
                isBigScreen ? "w-1/5" : "w-full mt-4"
              }`}
            >
              <div className="flex flex-col flex-grow mb-4 p-6 bg-bgColor-light rounded-3xl">
                <span className="font-semibold text-black mb-4">
                  Order Summary
                </span>
                <div className="flex items-center justify-between">
                  <span className="font-semibold text-gray-400 mb-4 text-sm">
                    Order Created
                  </span>
                  <span className="font-semibold text-black mb-4 text-sm">
                    {moment(order.dateOrdered).format("MMMM Do YYYY")}
                  </span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="font-semibold text-gray-400 mb-4 text-sm">
                    Payment
                  </span>
                  <span className="font-semibold text-black mb-4 text-sm">
                    {order.payment}
                  </span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="font-semibold text-gray-400 mb-4 text-sm">
                    Delivery
                  </span>
                  <span className="font-semibold text-black mb-4 text-sm">
                    {order.deliveryType}
                  </span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="font-semibold text-gray-400 mb-4 text-sm">
                    Delivery Fee
                  </span>
                  <span className="font-semibold text-black mb-4 text-sm">
                    {order.deliveryFee}
                  </span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="font-semibold text-black mb-4 text-lg">
                    Total
                  </span>
                  <span className="font-semibold text-black mb-4 text-lg">
                    {order.totalPrice}
                  </span>
                </div>
              </div>
              <div className="flex flex-col flex-grow mb-4 p-6 bg-bgColor-light rounded-3xl">
                <span className="font-semibold text-black mb-4">
                  User Summary
                </span>
                <div className="flex items-center justify-between">
                  <span className="font-semibold text-gray-400 mb-4 text-sm">
                    Name
                  </span>
                  <span className="font-semibold text-black mb-4 text-sm">
                    {order.user.username.charAt(0).toUpperCase() +
                      order.user.username.slice(1)}
                  </span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="font-semibold text-gray-400 mb-4 text-sm">
                    Email
                  </span>
                  <span className="font-semibold text-black mb-4 text-sm">
                    {order.user.email.charAt(0).toUpperCase() +
                      order.user.email.slice(1)}
                  </span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="font-semibold text-gray-400 mb-4 text-sm">
                    Phone
                  </span>
                  <span className="font-semibold text-black mb-4 text-sm">
                    {order.phone}
                  </span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="font-semibold text-gray-400 mb-4 text-sm">
                    Address
                  </span>
                  <span className="font-semibold text-black mb-4 text-sm">
                    {order.shippingAddress}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default OrderDetails;
