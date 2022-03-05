import axios from "axios";

const api = axios.create();
const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const login = async (email, password) => {
  const res = await api.post(
    `${BaseUrl}/api/admin/login`,
    {
      email,
      password,
    },
    {
      headers: {
        Authorization: `Bearer ${JSON.parse(
          localStorage.getItem("accessToken")
        )}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );
  const json = await res.json();
  return json;
};

export const getUserById = async (id) => {
  const res = await api.get(`${BaseUrl}/api/users/${id}`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
    },
  });
  const json = await res.json();
  return json;
};

export const getUsers = async (page, limit, pagination) => {
  const res = await api.get(
    `${BaseUrl}/api/users/allUsers?page=${page}&limit=${limit}&pagination=${pagination}`,
    {
      headers: {
        Authorization: `Bearer ${JSON.parse(
          localStorage.getItem("accessToken")
        )}`,
        "Content-type": "application/json",
      },
    }
  );
  const json = await res.json();
  return json;
};

export const deleteUser = async (id, profileId) => {
  const res = await api.delete(`${BaseUrl}/api/users/delete/${id}`, {
    headers: {
      Authorization: `Bearer ${JSON.parse(
        localStorage.getItem("accessToken")
      )}`,
      "Content-type": "application/json",
      Accept: "application/json",
    },
    data: { profileId: profileId },
  });
  const json = await res.json();
  return json;
};

export const logout = async () => {
  const res = await api.post(
    `${BaseUrl}/api/admin/logout`,
    { withCredentials: true },
    {
      headers: {
        Authorization: `Bearer ${JSON.parse(
          localStorage.getItem("accessToken")
        )}`,
        "Content-type": "application/json",
        Accept: "application/json",
      },
    }
  );
  const json = await res.json();
  return json;
};

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
