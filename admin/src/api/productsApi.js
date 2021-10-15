import axios from "axios";
import Cookies from "universal-cookie";

const cookies = new Cookies();
const api = axios.create();

// List of all the endpoints
export const addProduct = (
  name,
  description,
  fullDescription,
  category,
  countInStock,
  isFeatured,
  price,
  image,
  subCategory,
  onSale,
  discount
) =>
  api.post(
    "/api/products/add",
    {
      name,
      description,
      fullDescription,
      category,
      countInStock,
      isFeatured,
      price,
      image,
      subCategory,
      onSale,
      discount,
    },
    {
      headers: {
        Authorization: `Bearer ${cookies.get("refreshToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );
export const uploadMultiImages = (id, images) =>
  api.patch(
    `/api/products/multipleImages/${id}`,
    { images },
    {
      headers: {
        Authorization: `Bearer ${cookies.get("refreshToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const getProducts = () =>
  api.get("/api/products/get", {
    headers: {
      Authorization: `Bearer ${cookies.get("refreshToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const getProductById = (id) =>
  api.get(`/api/products/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("refreshToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const getRecentReviews = (id) =>
  api.get("/api/products/getRecentReviews", {
    headers: {
      Authorization: `Bearer ${cookies.get("refreshToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const deleteProduct = (id, thumbnailId, imageIds) =>
  api.delete(`/api/products/delete/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("refreshToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { thumbnailId: thumbnailId, imageIds: imageIds },
  });

export default api;
