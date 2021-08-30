const express = require("express");
const router = express.Router();

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

router.post("/add", cleanBody, addCategory);
router.get("/get", cleanBody, getCategories);
router.get("/count", cleanBody, count);
router.get("/:id", cleanBody, getCategoryById);
router.patch("/addSubCategory/:id", cleanBody, addSubCategory);
router.patch("/update/:id", cleanBody, updateCategory);
router.patch("/updateSubCategory/:id", cleanBody, updateSubCategory);
router.delete("/:id", cleanBody, deleteCategory);

module.exports = router;
