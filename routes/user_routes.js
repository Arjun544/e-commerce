const express = require("express");
const cleanBody = require("../middlewares/cleanBody");
const router = express.Router();
const upload = require("../config/multer");

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
  getShipAddress,
  updateImage,
} = require("../controllers/user_controllers");

router.post("/login", cleanBody, logIn);
router.post("/register", cleanBody, register);
router.post("/wishlist", cleanBody, getWishlist);
router.patch("/activate", cleanBody, activate);
router.patch("/forgotPassword", cleanBody, forgotPassword);
router.patch("/resetPassword", cleanBody, resetPassword);
router.patch("/addAddress/:id", cleanBody, addShippingAddress);
router.patch(
  "/updateImage/:id",
  upload.single("image"),
  cleanBody,
  updateImage
);
router.get("/allUsers", cleanBody, getAllUsers);
router.get("/count", cleanBody, count);
router.get("/getShipAddress/:id", cleanBody, getShipAddress);
router.get("/:id", cleanBody, getUserById);
router.patch("/update/:id", cleanBody, updateUser);
router.patch("/wishlist/:userId", cleanBody, clearWishlist);
router.delete("/delete/:id", cleanBody, deleteUserById);

module.exports = router;
