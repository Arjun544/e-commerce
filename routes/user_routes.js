const express = require("express");
const cleanBody = require("../middlewares/cleanBody");
const router = express.Router();
const upload = require("../config/multer");
const authMiddleware = require("../middlewares/auth_middleware");

const {
  register,
  logIn,
  activate,
  forgotPassword,
  resetPassword,
  getAllUsers,
  getUserById,
  deleteUserById,
  updateUser,
  count,
  getWishlist,
  addShippingAddress,
  sendCode,
  editShippingAddress,
  removeAddress,
  updateImage,
} = require("../controllers/user_controllers");

router.post("/login", cleanBody, logIn);
router.post("/register", cleanBody, register);
router.patch("/sendCode", cleanBody, sendCode);
router.post("/wishlist", cleanBody, getWishlist);
router.patch("/activate", cleanBody, activate);
router.patch("/forgotPassword", cleanBody, forgotPassword);
router.patch("/resetPassword", authMiddleware, cleanBody, resetPassword);
router.patch("/addAddress/:id", authMiddleware, cleanBody, addShippingAddress);
router.patch(
  "/editAddress/:id",
  authMiddleware,
  cleanBody,
  editShippingAddress
);
router.patch("/removeAddress/:id", authMiddleware, cleanBody, removeAddress);
router.patch(
  "/updateImage/:id",
  upload.single("image"),
  authMiddleware,
  cleanBody,
  updateImage
);
router.get("/allUsers", authMiddleware, cleanBody, getAllUsers);
router.get("/count", authMiddleware, cleanBody, count);
router.get("/:id", cleanBody, getUserById);
router.patch("/update/:id", authMiddleware, cleanBody, updateUser);
router.delete("/delete/:id", authMiddleware, cleanBody, deleteUserById);

module.exports = router;
