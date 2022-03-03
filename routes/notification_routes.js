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
  getAllNotification,
  updateHasRead,
  updateAllAsRead,
  deleteNotificationById,
  clearAll,
} = require("../controllers/notification_controller");

router.get("/get", cleanBody, authMiddleware, getAllNotification);
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
router.patch("/updateHasRead/:id", cleanBody, authMiddleware, updateHasRead);
router.patch("/markAllAsRead", cleanBody, authMiddleware, updateAllAsRead);
router.delete("/delete/:id", cleanBody, authMiddleware, deleteNotificationById);
router.delete("/clear", cleanBody, authMiddleware, clearAll);

module.exports = router;