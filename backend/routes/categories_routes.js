const express = require("express");
const router = express.Router();

const cleanBody = require("../middlewares/cleanBody");
const {
  addCategory,
  getCategories,
  getCategoryById,
  count,
  updateCategory,
  deleteCategory,
} = require("../controllers/categories_controller");

router.post("/add", cleanBody, addCategory);
router.get("/get", cleanBody, getCategories);
router.get("/count", cleanBody, count);
router.get("/:id", cleanBody, getCategoryById);
router.patch("/update/:id", cleanBody, updateCategory);
router.delete("/:id", cleanBody, deleteCategory);

module.exports = router;
