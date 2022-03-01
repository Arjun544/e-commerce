const express = require("express");
const router = express.Router();
const authMiddleware = require("../middlewares/auth_middleware");
const cleanBody = require("../middlewares/cleanBody");
const upload = require("../config/multer");

const {
  addCategory,
  addSubCategory,
  getCategories,
  getAdminCategories,
  getCategoryById,
  count,
  updateCategory,
  updateSubCategory,
  deleteCategory,
  deleteSubCategory,
  updateStatus,
} = require("../controllers/categories_controller");

router.post(
  "/add",
  authMiddleware,
  upload.single("icon"),
  cleanBody,
  addCategory
);
router.get("/getAdminCategories", cleanBody, getAdminCategories);
router.get("/get", cleanBody, getCategories);
router.get("/count", authMiddleware, cleanBody, count);
router.get("/:id", authMiddleware, cleanBody, getCategoryById);
router.delete("/:id", authMiddleware, cleanBody, deleteCategory);
router.delete("/subCategory/:id", authMiddleware, cleanBody, deleteSubCategory);
router.patch("/addSubCategory/:id",authMiddleware, cleanBody, addSubCategory);
router.patch("/update/:id", cleanBody,authMiddleware, updateCategory);
router.patch("/updateSubCategory/:id", authMiddleware, cleanBody, updateSubCategory);
router.patch(
  "/updateStatus/:id/:status",
  authMiddleware,
  cleanBody,
  updateStatus
);


module.exports = router;
