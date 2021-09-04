const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");

const {
  createCustomer,
  getCustomerCard,
  payAmount,
} = require("../controllers/payment_controller");

router.post("/createCustomer", cleanBody, createCustomer);
router.get("/getCustomerCard/:id/:card", cleanBody, getCustomerCard);
router.post("/pay", cleanBody, payAmount);

module.exports = router;
