const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
const authMiddleware = require("../middlewares/auth_middleware");

const {
  addToCart,
  getCart,
  updateQuantity,
  deleteFromCart,
  clearCart,
} = require("../controllers/cart_controller");

router.post("/addToCart",authMiddleware, cleanBody, addToCart);
router.get("/getCart/:id", authMiddleware, cleanBody, getCart);
router.patch("/updateQuantity/:id", authMiddleware, cleanBody, updateQuantity);
router.delete("/:id", cleanBody, authMiddleware, deleteFromCart);
router.delete("/clear/:userId", authMiddleware, cleanBody, clearCart);

module.exports = router;
