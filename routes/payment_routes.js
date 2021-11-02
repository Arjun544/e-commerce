const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
const authMiddleware = require("../middlewares/auth_middleware");


const {
  addPaymentMethods,
  getCustomerCards,
  payAmount,
} = require("../controllers/payment_controller");

router.post("/addPaymentMethods", authMiddleware, cleanBody, addPaymentMethods);
router.get(
  "/getCustomerCards/:id",
  authMiddleware,
  cleanBody,
  getCustomerCards
);
router.post("/pay", authMiddleware, cleanBody, payAmount);

module.exports = router;
