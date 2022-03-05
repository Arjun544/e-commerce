import axios from "axios";
import { useSelector } from "react-redux";

const api = axios.create();
const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const getOrders = async (page, limit, pagination) => {
  return await api.get(
    `${BaseUrl}/api/orders/get?page=${page}&limit=${limit}&pagination=${pagination}`,
    {
      headers: {
        Authorization: `Bearer ${JSON.parse(
          localStorage.getItem("accessToken")
        )}`,
        "Content-type": "application/json",
      },
    }
  );
};

export const getUserOrders = async (id) =>
  await api.get(`${BaseUrl}/api/orders/userOrders/${id}`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const getOrderById = async (id) =>
  await api.get(`${BaseUrl}/api/orders/${id}`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const updateStatus = async (id, status, paidStatus, isSettingOrders) =>
  await api.patch(
    `${BaseUrl}/api/orders/${id}`,
    { status, paidStatus, isSettingOrders },
    {
      headers: {
        Authorization: `Bearer ${JSON.parse(
          localStorage.getItem("accessToken")
        )}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export default api;
