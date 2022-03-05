import axios from "axios";

axios.defaults.withCredentials = true;
const api = axios.create();
api.defaults.withCredentials = true;

const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const getOrders = async (page, limit, pagination) => {
  return await api.get(
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
  await api.get(
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
  await api.get(
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
  await api.patch(
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

export default api;
