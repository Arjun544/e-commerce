import axios from "axios";

const api = axios.create();
const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const addDeal = async (title, products) =>
  await api.post(
    `${BaseUrl}/api/deal/add`,
    {
      title,
      products,
    },
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const getDeals = async () =>
  await api.get(`${BaseUrl}/api/deal/get`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
    },
  });

export const updateDeal = async (id, title, startDate, endDate) =>
  await api.patch(
    `${BaseUrl}/api/deal/update/${id}`,
    { title, startDate, endDate },
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );
export const addDealProducts = async (id, product, products) =>
  await api.patch(
    `${BaseUrl}/api/deal/addDealProducts/${id}`,
    { product, products },
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const removeDealProducts = async (id, productId, productPrice) =>
  await api.patch(
    `${BaseUrl}/api/deal/removeDealProduct/${id}`,
    { productId, productPrice },
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const updateStatus = async (id, status) =>
  await api.patch(
    `${BaseUrl}/api/deal/updateStatus/${id}/${status}`,
    {},
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const deleteDeal = async (id) =>
  await api.delete(`${BaseUrl}/api/deal/delete/${id}`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: {},
  });
