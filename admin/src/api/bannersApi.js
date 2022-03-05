import axios from "axios";

axios.defaults.withCredentials = true;
const api = axios.create();
api.defaults.withCredentials = true;

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
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

export const getBanners = async () =>
  await api.get(
    `${BaseUrl}/api/banners/get`,
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

export const updateBanner = async (id, image, imageId) =>
  await api.patch(
    `${BaseUrl}/api/banners/update/${id}`,
    { image, imageId },
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

export const addBannerProducts = async (id, product, products) =>
  await api.patch(
    `${BaseUrl}/api/banners/addBannerProducts/${id}`,
    { product, products },
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

export const removeBannerProducts = async (id, productId, productPrice) =>
  await api.patch(
    `${BaseUrl}/api/banners/removeBannerProduct/${id}`,
    { productId, productPrice },
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

export const updateStatus = async (id, status) =>
  await api.patch(
    `${BaseUrl}/api/banners/updateStatus/${id}/${status}`,
    {},
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

export const deleteBanner = async (id, imageId) =>
  await api.delete(
    `${BaseUrl}/api/banners/deleteBanner/${id}`,
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
      data: { imageId: imageId },
    },
    { withCredentials: true }
  );
