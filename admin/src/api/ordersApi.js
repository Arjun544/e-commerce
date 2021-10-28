import axios from "axios";
import Cookies from "universal-cookie";
const cookies = new Cookies();
const api = axios.create();

// List of all the endpoints
export const getUserOrders = (id) =>
  api.get(`/api/orders/userOrders/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });
export default api;
