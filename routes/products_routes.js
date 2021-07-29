const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
require("../config/cloudinary.config");
const upload = require("../config/multer");

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
  filterByPrice,
  sorting,
  NewArrivalProducts,
  getProductsByCategory,
} = require("../controllers/products_controller");

router.post("/add", upload.single("image"), cleanBody, addProduct);
router.patch("/addReview/:id", cleanBody, addReview);
router.get("/get", cleanBody, getProducts);
router.get("/newArrival", cleanBody, NewArrivalProducts);
router.get("/count", cleanBody, count);
router.get("/filterByPrice", cleanBody, filterByPrice);
router.patch("/multipleImages/:id", upload.array("images", 4), multipleImages);
router.get("/sorting", cleanBody, sorting);
router.get("/featured", cleanBody, featuredProducts);
router.get("/:id", cleanBody, getProductById);
router.get("/byCategory/:category/:currentId", cleanBody, getProductsByCategory);
router.patch("/update/:id", cleanBody, updateProduct);
router.delete("/delete/:id", cleanBody, deleteProduct);

module.exports = router;
