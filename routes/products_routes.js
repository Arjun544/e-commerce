const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
require("../config/cloudinary.config");
const upload = require("../config/multer");
const authMiddleware = require("../middlewares/auth_middleware");

const {
  addProduct,
  getAdminProducts,
  getProductById,
  featuredProducts,
  updateProduct,
  count,
  deleteProduct,
  multipleImages,
  productsByCategory,
  filterByPrice,
  sortProducts,
  NewArrivalProducts,
  getSimilarProducts,
  searchProducts,
  updateFeatured,
  updateStatus,
  getProducts,
} = require("../controllers/products_controller");

router.post(
  "/add",
  authMiddleware,
  upload.single("thumbnail"),
  cleanBody,
  addProduct
);
router.get("/getProducts", cleanBody, getProducts);
router.get("/getAdminProducts", cleanBody, authMiddleware, getAdminProducts);
router.get("/newArrival", cleanBody, NewArrivalProducts);
router.get("/count", authMiddleware, cleanBody, count);
router.get("/filterByPrice", authMiddleware, cleanBody, filterByPrice);
router.patch(
  "/multipleImages/:id",
  authMiddleware,
  upload.array("images", 4),
  multipleImages
);
router.get("/sorting", authMiddleware, cleanBody, sortProducts);
router.get("/featured", cleanBody, featuredProducts);
router.get("/:id", authMiddleware, cleanBody, getProductById);
router.get("/search/:query", authMiddleware, cleanBody, searchProducts);
router.get("/similar/:category/:currentId", cleanBody, getSimilarProducts);
router.get("/byCategory/:categoryId", cleanBody, productsByCategory);
router.patch("/update/:id", authMiddleware, cleanBody, updateProduct);
router.patch(
  "/updateFeatured/:id/:isFeatured",
  authMiddleware,
  cleanBody,
  updateFeatured
);
router.patch(
  "/updateStatus/:id/:status",
  authMiddleware,
  cleanBody,
  updateStatus
);
router.delete("/delete/:id", authMiddleware, cleanBody, deleteProduct);

module.exports = router;
