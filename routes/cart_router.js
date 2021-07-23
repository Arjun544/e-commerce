const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");

const {
  addToCart,
  getCart,
  updateQuantity,
  // decrementQuantity,
  deleteFromCart,
  clearCart,
} = require("../controllers/cart_controller");

router.post("/addToCart", cleanBody, addToCart);
router.get("/getCart/:id", cleanBody, getCart);
router.patch("/incrementQuantity/:id", cleanBody, updateQuantity);
// router.patch("/decrementQuantity/:id", cleanBody, decrementQuantity);
router.delete("/:id", cleanBody, deleteFromCart);
router.delete("/clear/:userId", cleanBody, clearCart);

module.exports = router;
