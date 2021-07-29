const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");

const {
  addToCart,
  getCart,
  updateQuantity,
  deleteFromCart,
  clearCart,
} = require("../controllers/cart_controller");

router.post("/addToCart", cleanBody, addToCart);
router.get("/getCart/:id", cleanBody, getCart);
router.patch("/updateQuantity/:id", cleanBody, updateQuantity);
router.delete("/:id", cleanBody, deleteFromCart);
router.delete("/clear/:userId", cleanBody, clearCart);

module.exports = router;
