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
  clearWishlist,
  addShippingAddress,
  editShippingAddress,
  removeAddress,
  updateImage,
} = require("../controllers/user_controllers");

router.post("/login", cleanBody, logIn);
router.post("/register", cleanBody, register);
router.post("/wishlist", authMiddleware, cleanBody, getWishlist);
router.patch("/activate", cleanBody, activate);
router.patch(
  "/forgotPassword",
  authMiddleware,
  cleanBody,
  forgotPassword
);
router.patch(
  "/resetPassword",
  authMiddleware,
  cleanBody,
  resetPassword
);
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
  cleanBody,
  updateImage
);
router.get("/allUsers", authMiddleware, cleanBody, getAllUsers);
router.get("/count", authMiddleware, cleanBody, count);
router.get("/:id", authMiddleware, cleanBody, getUserById);
router.patch("/update/:id", authMiddleware, cleanBody, updateUser);
router.patch("/wishlist/:userId", authMiddleware, cleanBody, clearWishlist);
router.delete("/delete/:id", authMiddleware, cleanBody, deleteUserById);

module.exports = router;
