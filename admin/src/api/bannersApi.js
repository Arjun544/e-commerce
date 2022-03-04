import axios from "axios";
import Cookies from "universal-cookie";

const cookies = new Cookies();
const api = axios.create();

const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const addBanner = (image, type, products) =>
  api.post(
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

export const getBanners = () =>
  api.get(`${BaseUrl}/api/banners/get`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const updateBanner = (id, image, imageId) =>
  api.patch(
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

export const addBannerProducts = (id, product, products) =>
  api.patch(
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

export const removeBannerProducts = (id, productId, productPrice) =>
  api.patch(
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

export const updateStatus = (id, status) =>
  api.patch(
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

export const deleteBanner = (id, imageId) =>
  api.delete(`${BaseUrl}/api/banners/deleteBanner/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { imageId: imageId },
  });
