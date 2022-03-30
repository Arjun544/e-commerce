import axios from "axios";

const api = axios.create();
const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const login = async (email, password) =>
  await api.post(
    `${BaseUrl}/api/admin/login`,
    {
      email,
      password,
    },
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const getUserById = async (id) =>
  await api.get(`${BaseUrl}/api/users/${id}`, {
    headers: {
      Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
      "Content-type": "application/json",
    },
  });

export const getUsers = async (page, limit, pagination) =>
  await api.get(
    `${BaseUrl}/api/users/allUsers?page=${page}&limit=${limit}&pagination=${pagination}`,
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
      },
    }
  );

export const deleteUser = async (id, profileId) =>
  await api.delete(`${BaseUrl}/api/users/delete/${id}`, {
    headers: {
      Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { profileId: profileId },
  });

export const logout = async () => await
  api.post(
    `${BaseUrl}/api/admin/logout`,
    { withCredentials: true },
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export default api;
