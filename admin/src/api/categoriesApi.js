import axios from "axios";

axios.defaults.withCredentials = true;
const api = axios.create();
api.defaults.withCredentials = true;

const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const getCategories = async () =>
  await api.get(`${BaseUrl}/api/categories/getAdminCategories`, {
    headers: {
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const addCategory = async (name, icon) =>
  await api.post(
    `${BaseUrl}/api/categories/add`,
    { name, icon },
    {
      headers: {
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
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const deleteCategory = async (id, iconId) =>
  await api.delete(
    `${BaseUrl}/api/categories/${id}`,
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
      data: { iconId: iconId },
    },
    { withCredentials: true }
  );

export const deleteSubCategory = async (id, subCategoryId) =>
  await api.delete(
    `${BaseUrl}/api/categories/subCategory/${id}`,
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
      data: { subCategoryId: subCategoryId },
    },
    { withCredentials: true }
  );

export default api;
