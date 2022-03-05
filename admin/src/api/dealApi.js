import axios from "axios";

const api = axios.create();
const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const addDeal = async (title, products) => {
  const res = await api.post(
    `${BaseUrl}/api/deal/add`,
    {
      title,
      products,
    },
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
  const json = await res.json();
  return json;
};

export const getDeals = async () => {
  const res = await api.get(`${BaseUrl}/api/deal/get`, {
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

export const updateDeal = async (id, title, startDate, endDate) => {
  const res = await api.patch(
    `${BaseUrl}/api/deal/update/${id}`,
    { title, startDate, endDate },
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
  const json = await res.json();
  return json;
};

export const addDealProducts = async (id, product, products) => {
  const res = await api.patch(
    `${BaseUrl}/api/deal/addDealProducts/${id}`,
    { product, products },
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
  const json = await res.json();
  return json;
};

export const removeDealProducts = async (id, productId, productPrice) => {
  const res = await api.patch(
    `${BaseUrl}/api/deal/removeDealProduct/${id}`,
    { productId, productPrice },
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
  const json = await res.json();
  return json;
};

export const updateStatus = async (id, status) => {
  const res = await api.patch(
    `${BaseUrl}/api/deal/updateStatus/${id}/${status}`,
    {},
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
  const json = await res.json();
  return json;
};

export const deleteDeal = async (id) => {
  const res = await api.delete(`${BaseUrl}/api/deal/delete/${id}`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: {},
  });
  const json = await res.json();
  return json;
};
