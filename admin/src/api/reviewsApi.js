import axios from "axios";
import Cookies from "universal-cookie";

const cookies = new Cookies();
const api = axios.create();

const BaseUrl = process.env.REACT_APP_API_URL;

export const getAllReviews = async (page, limit, pagination) =>
  await api.get(
    `${BaseUrl}/api/reviews/get?page=${page}&limit=${limit}&pagination=${pagination}`,
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

export const getRecentReviews = async () =>
  await api.get(
    `${BaseUrl}/api/reviews/getRecentReviews`,
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
