const express = require("express");
const router = express.Router();
const authMiddleware = require("../middlewares/auth_middleware");
const cleanBody = require("../middlewares/cleanBody");

const {
  addCategory,
  addSubCategory,
  getCategories,
  getCategoryById,
  count,
  updateCategory,
  updateSubCategory,
  deleteCategory,
} = require("../controllers/categories_controller");

router.post("/add", authMiddleware, cleanBody, addCategory);
router.get("/get", authMiddleware, cleanBody, getCategories);
router.get("/count", authMiddleware, cleanBody, count);
router.get("/:id", authMiddleware, cleanBody, getCategoryById);
router.patch("/addSubCategory/:id",authMiddleware, cleanBody, addSubCategory);
router.patch("/update/:id", cleanBody,authMiddleware, updateCategory);
router.patch("/updateSubCategory/:id",authMiddleware, cleanBody, updateSubCategory);
router.delete("/:id",authMiddleware, cleanBody, deleteCategory);

module.exports = router;
