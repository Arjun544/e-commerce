import axios from "axios";
import Cookies from "universal-cookie";
const cookies = new Cookies();
const api = axios.create();

const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const getOrders = async (page, limit, pagination) => {
console.log("cookie", cookies.get("accessToken"));
  return await api.get(
    `${BaseUrl}/api/orders/get?page=${page}&limit=${limit}&pagination=${pagination}`,
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
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
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
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
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
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
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

export default api;
