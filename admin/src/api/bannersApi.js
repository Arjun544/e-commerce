import axios from "axios";
import Cookies from "universal-cookie";

const cookies = new Cookies();
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
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const getBanners = async () =>
  await api.get(`${BaseUrl}/api/banners/get`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const updateBanner = async (id, image, imageId) =>
 await api.patch(
    `${BaseUrl}/api/banners/update/${id}`,
    { image, imageId },
    {
      headers: {
        "Content-type": "application/json",
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        Accept: "application/json",
      },
    }
  );

export const addBannerProducts = async (id, product, products) =>
  await api.patch(
    `${BaseUrl}/api/banners/addBannerProducts/${id}`,
    { product, products },
    {
      headers: {
        "Content-type": "application/json",
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        Accept: "application/json",
      },
    }
  );

export const removeBannerProducts = async (id, productId, productPrice) =>
 await api.patch(
    `${BaseUrl}/api/banners/removeBannerProduct/${id}`,
    { productId, productPrice },
    {
      headers: {
        "Content-type": "application/json",
        Authorization: `Bearer ${cookies.get("accessToken")}`,
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
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const deleteBanner = async (id, imageId) =>
  await api.delete(`${BaseUrl}/api/banners/deleteBanner/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { imageId: imageId },
  });
