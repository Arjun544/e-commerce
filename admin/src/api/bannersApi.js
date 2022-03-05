import axios from "axios";

const api = axios.create();
const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const addBanner = async (image, type, products) =>
  await api.post(
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

export const getBanners = async () =>
  await api.get(
    `${BaseUrl}/api/banners/get`,
    {
      headers: {
        Authorization: `Bearer ${JSON.parse(
          localStorage.getItem("accessToken")
        )}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
  );

export const updateBanner = async (id, image, imageId) =>
  await api.patch(
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
    },
  );

export const addBannerProducts = async (id, product, products) =>
  await api.patch(
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
    },
  );

export const removeBannerProducts = async (id, productId, productPrice) =>
  await api.patch(
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

export const updateStatus = async (id, status) =>
  await api.patch(
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

export const deleteBanner = async (id, imageId) =>
  await api.delete(`${BaseUrl}/api/banners/deleteBanner/${id}`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { imageId: imageId },
  });

  export default api;
