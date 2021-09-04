const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");

const {
  createCustomer,
  getCustomer,
  getCustomerCards,
  addNewCard,
  payAmount,
} = require("../controllers/payment_controller");

router.post("/createCustomer", cleanBody, createCustomer);
router.get("/getCustomer", cleanBody, getCustomer);
router.get("/getCustomerCards", cleanBody, getCustomerCards);
router.post("/addNewCard", cleanBody, addNewCard);
router.post("/pay", cleanBody, payAmount);

module.exports = router;
