const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
const authMiddleware = require("../middlewares/auth_middleware");
const upload = require("../config/multer");

const {
  sendFirebaseNotification,
  sendToAllUsers,
} = require("../controllers/notification_controller");

router.post("/send", cleanBody, authMiddleware, sendFirebaseNotification);
router.post(
  "/sendToAllUsers",
  cleanBody,
  upload.single("image"),
  authMiddleware,
  sendToAllUsers
);

module.exports = router;
