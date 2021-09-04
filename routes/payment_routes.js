const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");

const {
  createCustomer,
  getCustomer,
  getCustomerTransactions,
  getCustomerCards,
  addNewCard,
  payAmount,
} = require("../controllers/payment_controller");

router.post("/createCustomer", cleanBody, createCustomer);
router.get("/getCustomer/:id", cleanBody, getCustomer);
router.get("/getCustomerTransactions/:id", cleanBody, getCustomerTransactions);
router.get("/getCustomerCards/:id", cleanBody, getCustomerCards);
router.post("/addNewCard", cleanBody, addNewCard);
router.post("/pay", cleanBody, payAmount);

module.exports = router;
