const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
const authMiddleware = require("../middlewares/auth_middleware");


const {
  createCustomer,
  getCustomerCard,
  payAmount,
} = require("../controllers/payment_controller");

router.post("/createCustomer", authMiddleware, cleanBody, createCustomer);
router.get(
  "/getCustomerCard/:id/:card",
  authMiddleware,
  cleanBody,
  getCustomerCard
);
router.post("/pay", authMiddleware, cleanBody, payAmount);

module.exports = router;
