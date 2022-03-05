import axios from "axios";

const api = axios.create();
const BaseUrl = process.env.REACT_APP_API_URL;

export const getAllReviews = async (page, limit, pagination) => {
  const res = await api.get(
    `${BaseUrl}/api/reviews/get?page=${page}&limit=${limit}&pagination=${pagination}`,
    {
      headers: {
        Authorization: `Bearer ${JSON.parse(
          localStorage.getItem("accessToken")
        )}`,
        "Content-type": "application/json",
      },
    }
  );
  const json = await res.json();
  return json;
};

export const getRecentReviews = async () => {
  const res = await api.get(`${BaseUrl}/api/reviews/getRecentReviews`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
    },
  });
  const json = await res.json();
  return json;
};

export default api;
