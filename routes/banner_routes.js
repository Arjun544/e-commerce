const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
const authMiddleware = require("../middlewares/auth_middleware");
require("../config/cloudinary.config");
const upload = require("../config/multer");

const {
  addBanner,
  getAdminBanners,
  getUserBanners,
  deleteBanner,
  updateStatus,
  updateBanner,
  addBannerProducts,
  removeBannerProduct,
} = require("../controllers/banners_controller");

router.post(
  "/add",
  authMiddleware,
  upload.single("image"),
  cleanBody,
  addBanner
);
router.get("/get", authMiddleware, cleanBody, getAdminBanners);
router.get("/getUserBanners", cleanBody, getUserBanners);
router.patch(
  "/updateStatus/:id/:status",
  authMiddleware,
  cleanBody,
  updateStatus
);
router.patch("/update/:id", authMiddleware, cleanBody, updateBanner);
router.patch(
  "/addBannerProducts/:id",
  authMiddleware,
  cleanBody,
  addBannerProducts
);
router.patch(
  "/removeBannerProduct/:id",
  authMiddleware,
  cleanBody,
  removeBannerProduct,
);
router.delete("/deleteBanner/:id", authMiddleware, cleanBody, deleteBanner);

module.exports = router;
