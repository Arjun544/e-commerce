import axios from "axios";

axios.defaults.withCredentials = true;
const api = axios.create();
api.defaults.withCredentials = true;

const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const sendNotificationToAllUsers = async (title, body, image) =>
  await api.post(
    `${BaseUrl}/api/notification/sendToAllUsers`,
    {
      title,
      body,
      image,
    },
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );

export const NotifyUser = async (title, body) =>
  await api.post(
    `${BaseUrl}/api/notification/send`,
    {
      title,
      body,
    },
    {
      headers: {
        "Content-type": "application/json",
        Accept: "application/json",
      },
    },
    { withCredentials: true }
  );
