const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");

const {
  logIn,
  logout,
  refreshToken,
} = require("../controllers/admin_controller");

router.post("/login", cleanBody, logIn);
router.post("/logout", cleanBody, logout);
router.get("/refresh", cleanBody, refreshToken);

module.exports = router;
