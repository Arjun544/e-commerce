import axios from "axios";
import Cookies from "universal-cookie";

const cookies = new Cookies();
const api = axios.create();

// List of all the endpoints
export const sendNotificationToAllUsers = (title, body, image) =>
    api.post(
        "/api/notification/sendToAllUsers", {
            title,
            body,
            image,
        }, {
            headers: {
                Authorization: `Bearer ${cookies.get("accessToken")}`,
                "Content-type": "application/json",
                Accept: "application/json",
            },
        }
    );

export const NotifyUser = (title, body) =>
    api.post(
        "/api/notification/send", {
            title,
            body,
        }, {
            headers: {
                Authorization: `Bearer ${cookies.get("accessToken")}`,
                "Content-type": "application/json",
                Accept: "application/json",
            },
        }
    );