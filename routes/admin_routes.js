const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");

const {
  logIn,
  logout,
} = require("../controllers/admin_controller");

router.post("/login", cleanBody, logIn);
router.post("/logout", cleanBody, logout);

module.exports = router;
