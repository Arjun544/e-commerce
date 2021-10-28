import axios from "axios";
import Cookies from "universal-cookie";

const cookies = new Cookies();
const api = axios.create();

// List of all the endpoints
export const addCategory = (name, icon) =>
  api.post(
    "/api/categories/add",
    { name, icon },
    {
      headers: {
        "Content-type": "application/json",
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        Accept: "application/json",
      },
    }
  );

export const addSubCategory = (id, name) =>
  api.patch(
    `/api/categories/addSubCategory/${id}`,
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
    `/api/categories/update/${id}`,
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
    `/api/categories/updateSubCategory/${id}`,
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
  api.delete(`/api/categories/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { iconId: iconId },
  });

export const deleteSubCategory = (id, subCategoryId) =>
  api.delete(`/api/categories/subCategory/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { subCategoryId: subCategoryId },
  });

export const getCategories = () =>
  api.get("/api/categories/get", {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export default api;
