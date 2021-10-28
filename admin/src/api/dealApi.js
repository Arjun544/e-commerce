import axios from "axios";
import Cookies from "universal-cookie";

const cookies = new Cookies();
const api = axios.create();

// List of all the endpoints
export const addDeal = (title, startDate, endDate) =>
  api.post(
    "/api/deal/add",
    {
      title,
      startDate,
      endDate,
    },
    {
      headers: {
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const getDeals = () =>
  api.get("/api/deal/get", {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const updateDeal = (id, title, startDate, endDate) =>
  api.patch(
    `/api/deal/update/${id}`,
    { title, startDate, endDate },
    {
      headers: {
        "Content-type": "application/json",
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        Accept: "application/json",
      },
    }
  );
export const addDealProducts = (id, product, products) =>
  api.patch(
    `/api/deal/addDealProducts/${id}`,
    { product, products },
    {
      headers: {
        "Content-type": "application/json",
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        Accept: "application/json",
      },
    }
  );

export const removeDealProducts = (id, productId, productPrice) =>
  api.patch(
    `/api/deal/removeDealProduct/${id}`,
    { productId, productPrice },
    {
      headers: {
        "Content-type": "application/json",
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        Accept: "application/json",
      },
    }
  );

  export const updateStatus = (id, status) =>
    api.patch(
      `/api/deal/updateStatus/${id}/${status}`,
      {},
      {
        headers: {
          Authorization: `Bearer ${cookies.get("accessToken")}`,
          "Content-type": "application/json",
          Accept: "application/json",
        },
      }
    );

export const deleteDeal = (id) =>
  api.delete(`/api/deal/delete/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: {},
  });
