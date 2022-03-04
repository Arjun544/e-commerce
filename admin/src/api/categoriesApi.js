import axios from "axios";
import Cookies from "universal-cookie";

const cookies = new Cookies();
const api = axios.create();

const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const getCategories = () =>
  api.get(`${BaseUrl}/api/categories/getAdminCategories`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });
  
export const addCategory = (name, icon) =>
  api.post(
    `${BaseUrl}/api/categories/add`,
    { name, icon },
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
    `${BaseUrl}/api/categories/updateStatus/${id}/${status}`,
    {},
    {
      headers: {
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const addSubCategory = (id, name) =>
  api.patch(
    `${BaseUrl}/api/categories/addSubCategory/${id}`,
    { name },
    {
      headers: {
        "Content-type": "application/json",
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        Accept: "application/json",
      },
    }
  );

export const updateCategory = (id, name, icon, iconId) =>
  api.patch(
    `${BaseUrl}/api/categories/update/${id}`,
    { name, icon, iconId },
    {
      headers: {
        "Content-type": "application/json",
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        Accept: "application/json",
      },
    }
  );

export const updateSubCategory = (id, subCategoryId, name) =>
  api.patch(
    `${BaseUrl}/api/categories/updateSubCategory/${id}`,
    { subCategoryId, name },
    {
      headers: {
        "Content-type": "application/json",
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        Accept: "application/json",
      },
    }
  );

export const deleteCategory = (id, iconId) =>
  api.delete(`${BaseUrl}/api/categories/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { iconId: iconId },
  });

export const deleteSubCategory = (id, subCategoryId) =>
  api.delete(`${BaseUrl}/api/categories/subCategory/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { subCategoryId: subCategoryId },
  });



export default api;
