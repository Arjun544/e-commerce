const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
const authMiddleware = require("../middlewares/auth_middleware");


const {
  addCard,
  deleteCard,
  getCustomerCards,
  payAmount,
} = require("../controllers/payment_controller");

router.post("/addCard", authMiddleware, cleanBody, addCard);
router.post("/deleteCard/:id", authMiddleware, cleanBody, deleteCard);
router.get(
  "/getCustomerCards/:id",
  authMiddleware,
  cleanBody,
  getCustomerCards
);
router.post("/pay", authMiddleware, cleanBody, payAmount);

module.exports = router;
