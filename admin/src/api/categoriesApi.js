import axios from "axios";

const api = axios.create();
const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const getCategories = async () =>
  await api.get(`${BaseUrl}/api/categories/getAdminCategories`, {
    headers: {
      Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
      "Content-type": "application/json",
    },
  });

export const addCategory = async (name, icon) =>
  await api.post(
    `${BaseUrl}/api/categories/add`,
    { name, icon },
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
    `${BaseUrl}/api/categories/updateStatus/${id}/${status}`,
    {},
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const addSubCategory = async (id, name) =>
  await api.patch(
    `${BaseUrl}/api/categories/addSubCategory/${id}`,
    { name },
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const updateCategory = async (id, name, icon, iconId) =>
  await api.patch(
    `${BaseUrl}/api/categories/update/${id}`,
    { name, icon, iconId },
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const updateSubCategory = async (id, subCategoryId, name) =>
  await api.patch(
    `${BaseUrl}/api/categories/updateSubCategory/${id}`,
    { subCategoryId, name },
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const deleteCategory = async (id, iconId) =>
  await api.delete(`${BaseUrl}/api/categories/${id}`, {
    headers: {
      Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { iconId: iconId },
  });

export const deleteSubCategory = async (id, subCategoryId) =>
  await api.delete(`${BaseUrl}/api/categories/subCategory/${id}`, {
    headers: {
      Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { subCategoryId: subCategoryId },
  });

export default api;
