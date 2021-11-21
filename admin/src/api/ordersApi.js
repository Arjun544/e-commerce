import axios from "axios";
import Cookies from "universal-cookie";
const cookies = new Cookies();
const api = axios.create();

// List of all the endpoints
export const getOrders = () =>
  api.get("/api/orders/get", {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const getUserOrders = (id) =>
  api.get(`/api/orders/userOrders/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const getOrderById = (id) =>
  api.get(`/api/orders/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const updateStatus = (id, status, paidStatus, isSettingOrders) =>
  api.patch(
    `/api/orders/${id}`,
    { status, paidStatus, isSettingOrders },
    {
      headers: {
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export default api;
