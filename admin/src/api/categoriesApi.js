import axios from "axios";
import Cookies from "universal-cookie";

const cookies = new Cookies();
const api = axios.create();

// List of all the endpoints
export const addCategory = (name,icon) =>
  api.post(
    "/api/categories/add",
    { name, icon },
    {
      headers: {
        "Content-type": "application/json",
        Authorization: `Bearer ${cookies.get("refreshToken")}`,
        Accept: "application/json",
      },
    }
  );

export const getCategories = () =>
  api.get("/api/categories/get", {
    headers: {
      Authorization: `Bearer ${cookies.get("refreshToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export default api;
