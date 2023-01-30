import React from "react";
import { useSelector } from "react-redux";

const TopCustomers = () => {
  const { customers } = useSelector((state) => state.customers);
  const { orders } = useSelector((state) => state.orders);
  return (
    <div className="flex flex-col w-full">
      <span className="text-black font-semibold text-lg mb-4">
        Top Customers
      </span>

      {customers.slice(0, 10).map((customer, index) => (
        <div
          key={index}
          className="flex items-center justify-between h-24 mb-4 w-full bg-white rounded-3xl px-4 shadow-sm hover:shadow-md"
        >
          <div className="flex">
            {customer.profile ? (
              <img
                className="w-16 h-16 rounded-full mr-3 object-cover"
                src={customer.profile}
                alt=""
              />
            ) : (
              <img
                className="w-16 h-16 rounded-full mr-3 object-cover"
                src="https://schooloflanguages.sa.edu.au/wp-content/uploads/2017/11/placeholder-profile-sq.jpg"
                alt=""
              />
            )}
            <div className="flex flex-col justify-center">
              <span className="text-black font-semibold">
                {customer.username.charAt(0).toUpperCase() +
                  customer.username.slice(1)}
              </span>
              <div className="flex">
                <span className="text-Grey-dark font-semibold mr-2">
                  Orders:
                </span>
                <span className="text-black font-semibold">
                  {
                    orders.filter((order) => order.user._id === customer.id)
                      .length
                  }
                </span>
              </div>
            </div>
          </div>
          <div className="flex flex-col items-start">
            <span className="text-black text-sm">Spent</span>
            <span className="text-Grey-dark font-semibold mr-2">
              $
              {orders
                .filter((order) => order.user._id === customer.id)
                .map((item) => item.totalPrice)
                .reduce((a, b) => a + b, 0)}
            </span>
          </div>
        </div>
      ))}
    </div>
  );
};

export default TopCustomers;
