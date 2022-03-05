import axios from "axios";

const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const getOrders = async (page, limit, pagination) => {
  return await axios.get(
    `${BaseUrl}/api/orders/get?page=${page}&limit=${limit}&pagination=${pagination}`,
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );
  }

export const getUserOrders = async (id) =>
  await axios.get(
    `${BaseUrl}/api/orders/userOrders/${id}`,
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

export const getOrderById = async (id) =>
  await axios.get(
    `${BaseUrl}/api/orders/${id}`,
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

export const updateStatus = async (id, status, paidStatus, isSettingOrders) =>
  await axios.patch(
    `${BaseUrl}/api/orders/${id}`,
    { status, paidStatus, isSettingOrders },
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

