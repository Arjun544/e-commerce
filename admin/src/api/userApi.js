import axios from "axios";
const api = axios.create();
// const api = axios.create({
//   baseURL: process.env.REACT_APP_API_URL,
//   withCredentials: true,
//   headers: {
//     "Content-type": "application/json",
//     Accept: "application/json",
//     crossorigin: true,
//     "Access-Control-Allow-Origin": "*",
//   },
// });

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

// Interceptors;
api.interceptors.response.use(
  (config) => {
    return config;
  },
  async (error) => {
    const originalRequest = error.config;
    if (
      error.response.status === 401 &&
      originalRequest &&
      !originalRequest._isRetry
    ) {
      originalRequest.isRetry = true;
      try {
        await axios.get("/api/admin/refresh", {
          withCredentials: true,
        });

        return api.request(originalRequest);
      } catch (err) {
        console.log(err.message);
      }
    }
    throw error;
  }
);

export default api;
