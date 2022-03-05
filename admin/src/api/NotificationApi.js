import axios from "axios";

const api = axios.create();
const BaseUrl = process.env.REACT_APP_API_URL;

// List of all the endpoints
export const sendNotificationToAllUsers = async (title, body, image) => {
  const res = await api.post(
    `${BaseUrl}/api/notification/sendToAllUsers`,
    {
      title,
      body,
      image,
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

export const NotifyUser = async (title, body) => {
  const res = await api.post(
    `${BaseUrl}/api/notification/send`,
    {
      title,
      body,
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
