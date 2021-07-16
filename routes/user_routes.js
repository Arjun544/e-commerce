const express = require("express");
const cleanBody = require("../middlewares/cleanBody");
const router = express.Router();
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
  currentUser,
} = require("../controllers/user_controllers");

router.post("/login", cleanBody, logIn);
router.get("/currentUser", cleanBody, currentUser);
router.post("/register", cleanBody, register);
router.patch("/activate", cleanBody, activate);
router.patch("/forgotPassword", cleanBody, forgotPassword);
router.patch("/resetPassword", cleanBody, resetPassword);
router.get("/allUsers", cleanBody, getAllUsers);
router.get("/count", cleanBody, count);
router.get("/:id", cleanBody, getUserById);
router.patch("/update/:id", cleanBody, updateUser);
router.delete("/delete/:id", cleanBody, deleteUserById);

module.exports = router;
