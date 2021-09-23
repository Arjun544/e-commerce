import axios from "axios";
import Cookies from "universal-cookie";

const cookies = new Cookies();
const api = axios.create();

// List of all the endpoints
export const getProducts = () =>
  api.get("/api/products/get", {
    headers: {
      Authorization: `Bearer ${cookies.get("refreshToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });
export const getProductById = (id) =>
  api.get(`/api/products/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("refreshToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });
export const getRecentReviews = (id) =>
  api.get("/api/products/getRecentReviews", {
    headers: {
      Authorization: `Bearer ${cookies.get("refreshToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export default api;
