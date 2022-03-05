import axios from "axios";

axios.defaults.withCredentials = true;
const api = axios.create();
api.defaults.withCredentials = true;

const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const login = (email, password) =>
  api.post(
    `${BaseUrl}/api/admin/login`,
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
  api.get(
    `${BaseUrl}/api/users/${id}`,
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

export const getUsers = (page, limit, pagination) =>
  api.get(
    `${BaseUrl}/api/users/allUsers?page=${page}&limit=${limit}&pagination=${pagination}`,
    {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("accessToken")}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

export const deleteUser = (id, profileId) =>
  api.delete(
    `${BaseUrl}/api/users/delete/${id}`,
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
      data: { profileId: profileId },
    },
    { withCredentials: true }
  );

export const logout = () =>
  api.post(
    `${BaseUrl}/api/admin/logout`,
    { withCredentials: true },
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
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
