const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");

const { logIn } = require("../controllers/admin_controller");

router.post("/login", cleanBody, logIn);

module.exports = router;
