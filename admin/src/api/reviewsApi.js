import axios from "axios";

const api = axios.create();
const BaseUrl = process.env.REACT_APP_API_URL;

export const getAllReviews = async (page, limit, pagination) =>
  await api.get(
    `${BaseUrl}/api/reviews/get?page=${page}&limit=${limit}&pagination=${pagination}`,
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

export const getRecentReviews = async () =>
  await api.get(`${BaseUrl}/api/reviews/getRecentReviews`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export default api;
