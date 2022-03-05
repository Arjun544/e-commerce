import axios from "axios";


axios.defaults.withCredentials = true;
const api = axios.create();
api.defaults.withCredentials = true;

const BaseUrl = process.env.REACT_APP_API_URL;

export const getAllReviews = async (page, limit, pagination) =>
  await api.get(
    `${BaseUrl}/api/reviews/get?page=${page}&limit=${limit}&pagination=${pagination}`,
    {
      headers: {
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
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

export default api;
