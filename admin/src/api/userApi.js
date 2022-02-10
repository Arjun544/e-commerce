import axios from "axios";
import Cookies from "universal-cookie";
const cookies = new Cookies();
const api = axios.create();

// List of all the endpoints
export const login = (email, password) =>
  api.post(
    "/api/admin/login",
    {
      email,
      password,
    },
    { withCredentials: true },
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const getUserById = (id) =>
  api.get(`/api/users/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
  });

export const getUsers = (page, limit, pagination) =>
  api.get(
    `/api/users/allUsers?page=${page}&limit=${limit}&pagination=${pagination}`,
    {
      headers: {
        Authorization: `Bearer ${cookies.get("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

export const deleteUser = (id, profileId) =>
  api.delete(`/api/users/delete/${id}`, {
    headers: {
      Authorization: `Bearer ${cookies.get("accessToken")}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { profileId: profileId },
  });

export const logout = () =>
  api.post(
    "/api/admin/logout",
    { withCredentials: true },
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );

// Interceptors;
// api.interceptors.response.use(
//   (config) => {
//     return config;
//   },
//   async (error) => {
//     const originalRequest = error.config;
//     if (
//       error.response.status === 401 &&
//       originalRequest &&
//       !originalRequest._isRetry
//     ) {
//       originalRequest.isRetry = true;
//       try {
//         await axios.get("/api/admin/refresh", {
//           withCredentials: true,
//         });

//         return api.request(originalRequest);
//       } catch (err) {
//         console.log(err.message);
//       }
//     }
//     throw error;
//   }
// );

export default api;
