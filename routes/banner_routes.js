const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
const authMiddleware = require("../middlewares/auth_middleware");
require("../config/cloudinary.config");
const upload = require("../config/multer");

const {
  addBanner,
  getAdminBanners,
  deleteBanner,
  updateStatus,
  updateBanner,
} = require("../controllers/banners_controller");

router.post(
  "/add",
  authMiddleware,
  upload.single("image"),
  cleanBody,
  addBanner
);
router.get("/get", authMiddleware, cleanBody, getAdminBanners);
router.patch(
  "/updateStatus/:id/:status",
  authMiddleware,
  cleanBody,
  updateStatus
);
router.patch("/update/:id", authMiddleware, cleanBody, updateBanner);
router.delete("/deleteBanner/:id", authMiddleware, cleanBody, deleteBanner);

module.exports = router;
