import axios from "axios";

const api = axios.create();
const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const addBanner = async (image, type, products) => {

  const res =await api.post(
    `${BaseUrl}/api/banners/add`,
    {
      image,
      type,
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
  }

export const getBanners = async () => {
  const res = await api.get(`${BaseUrl}/api/banners/get`, {
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

export const updateBanner = async (id, image, imageId) => {
  const res = await api.patch(
    `${BaseUrl}/api/banners/update/${id}`,
    { image, imageId },
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
export const addBannerProducts = async (id, product, products) => {
  const res = await api.patch(
    `${BaseUrl}/api/banners/addBannerProducts/${id}`,
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

export const removeBannerProducts = async (id, productId, productPrice) => {
  const res = await api.patch(
    `${BaseUrl}/api/banners/removeBannerProduct/${id}`,
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
    `${BaseUrl}/api/banners/updateStatus/${id}/${status}`,
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

export const deleteBanner = async (id, imageId) => {
  const res = await api.delete(`${BaseUrl}/api/banners/deleteBanner/${id}`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { imageId: imageId },
  });
  const json = await res.json();
  return json;
};

export default api;
