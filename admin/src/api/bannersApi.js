import axios from "axios";
import Cookies from "universal-cookie";

const cookies = new Cookies();
const api = axios.create();

// List of all the endpoints
export const addBanner = (title, image, type, products) =>
  api.post(
    "/api/banners/add",
    {
      title,
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
  api.get("/api/banners/get", {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const updateBanner = (id, title, image, imageId) =>
  api.patch(
    `/api/banners/update/${id}`,
    { title, image, imageId },
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
    `/api/banners/addBannerProducts/${id}`,
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
    `/api/banners/removeBannerProduct/${id}`,
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
    `/api/banners/updateStatus/${id}/${status}`,
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
  api.delete(`/api/banners/deleteBanner/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { imageId: imageId },
  });
