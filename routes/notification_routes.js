const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
const authMiddleware = require("../middlewares/auth_middleware");
const upload = require("../config/multer");

const {
    sendNotification,
    notifyAllUsers,
    saveToken,
    deleteToken,
} = require("../controllers/notification_controller");

router.post("/send", cleanBody, authMiddleware, sendNotification);
router.post(
    "/sendToAllUsers",
    cleanBody,
    upload.single("image"),
    authMiddleware,
    notifyAllUsers
);
router.patch("/addToken", cleanBody, authMiddleware, saveToken);
router.patch("/deleteToken", cleanBody, authMiddleware, deleteToken);

module.exports = router;