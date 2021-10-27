import axios from "axios";
import Cookies from "universal-cookie";

const cookies = new Cookies();
const api = axios.create();

export const getAllReviews = () =>
  api.get("/api/reviews/get", {
    headers: {
      Authorization: `Bearer ${cookies.get("refreshToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const getRecentReviews = () =>
  api.get("/api/reviews/getRecentReviews", {
    headers: {
      Authorization: `Bearer ${cookies.get("refreshToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export default api;