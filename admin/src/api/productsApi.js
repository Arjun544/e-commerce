import axios from "axios";

const api = axios.create();
const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const addProduct = async (
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
  await api.post(
    `${BaseUrl}/api/products/add`,
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
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const uploadMultiImages = async (id, images) =>
  await api.patch(
    `${BaseUrl}/api/products/multipleImages/${id}`,
    { images },
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const getProducts = async (page, limit, pagination) =>
  await api.get(
    `${BaseUrl}/api/products/getAdminProducts?page=${page}&limit=${limit}&pagination=${pagination}`,
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
      },
    }
  );

export const getProductById = async (id) =>
  await api.get(`${BaseUrl}/api/products/${id}`, {
    headers: {
      Authorization: `Bearer ${
        localStorage.getItem("accessToken")
      }`,
      "Content-type": "application/json",
    },
  });

export const updateProduct = async (
  id,
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
  thumbnailId,
  imageIds
) =>
  await api.patch(
    `${BaseUrl}/api/products/update/${id}`,
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
      thumbnailId,
      imageIds,
    },
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const updateFeatured = async (id, isFeatured) =>
  await api.patch(
    `${BaseUrl}/api/products/updateFeatured/${id}/${isFeatured}`,
    {},
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
    `${BaseUrl}/api/products/updateStatus/${id}/${status}`,
    {},
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const deleteProduct = async (id, thumbnailId, imageIds) =>
  await api.delete(`${BaseUrl}/api/products/delete/${id}`, {
    headers: {
      Authorization: `Bearer ${
        localStorage.getItem("accessToken")
      }`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { thumbnailId: thumbnailId, imageIds: imageIds },
  });

export default api;
