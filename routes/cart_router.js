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
  cartCount,
} = require("../controllers/cart_controller");

router.post("/addToCart",authMiddleware, cleanBody, addToCart);
router.get("/getCart/:id", authMiddleware, cleanBody, getCart);
router.get("/cartCount/:id", authMiddleware, cleanBody, cartCount);
router.patch("/updateQuantity/:id", authMiddleware, cleanBody, updateQuantity);
router.patch("/:id", cleanBody, authMiddleware, deleteFromCart);
router.delete("/clear/:id", authMiddleware, cleanBody, clearCart);

module.exports = router;
