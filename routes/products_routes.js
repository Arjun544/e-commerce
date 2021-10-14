const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
require("../config/cloudinary.config");
const upload = require("../config/multer");
const authMiddleware = require("../middlewares/auth_middleware");

const {
  addProduct,
  getProducts,
  getProductById,
  featuredProducts,
  updateProduct,
  count,
  deleteProduct,
  multipleImages,
  addReview,
  productsByCategory,
  filterByPrice,
  sortProducts,
  NewArrivalProducts,
  getSimilarProducts,
  searchProducts,
  getRecentReviews,
} = require("../controllers/products_controller");

router.post(
  "/add",
  authMiddleware,
  upload.single("thumbnail"),
  cleanBody,
  addProduct
);
router.patch("/addReview/:id", authMiddleware, cleanBody, addReview);
router.get("/get", cleanBody, authMiddleware, getProducts);
router.get("/newArrival", authMiddleware, cleanBody, NewArrivalProducts);
router.get("/count", authMiddleware, cleanBody, count);
router.get("/getRecentReviews", authMiddleware, cleanBody, getRecentReviews);
router.get("/filterByPrice", authMiddleware, cleanBody, filterByPrice);
router.patch(
  "/multipleImages/:id",
  authMiddleware,
  upload.array("images", 4),
  multipleImages
);
router.get("/sorting", authMiddleware, cleanBody, sortProducts);
router.get("/featured", authMiddleware, cleanBody, featuredProducts);
router.get("/:id", authMiddleware, cleanBody, getProductById);
router.get("/search/:query", authMiddleware, cleanBody, searchProducts);
router.get(
  "/similar/:category/:currentId",
  authMiddleware,
  cleanBody,
  getSimilarProducts
);
router.get("/byCategory/:categoryId", cleanBody, productsByCategory);
router.patch("/update/:id", authMiddleware, cleanBody, updateProduct);
router.delete("/delete/:id", authMiddleware, cleanBody, deleteProduct);

module.exports = router;
