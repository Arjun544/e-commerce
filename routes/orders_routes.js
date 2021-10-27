const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
const authMiddleware = require("../middlewares/auth_middleware");

const {
  addOrder,
  getOrders,
  getOrderById,
  updateStatus,
  deleteOrder,
  totalSales,
  count,
  userOrders,
} = require("../controllers/orders_controller");

router.post("/add", authMiddleware, cleanBody, addOrder);
router.get("/get", authMiddleware, cleanBody, authMiddleware, getOrders);
router.get("/totalsales", authMiddleware, cleanBody, totalSales);
router.get("/count", authMiddleware, cleanBody, count);
router.get("/userOrders/:id", authMiddleware, cleanBody, userOrders);
router.get("/:id", authMiddleware, cleanBody, getOrderById);
router.patch("/:id", authMiddleware, cleanBody, updateStatus);
router.delete("/:id", authMiddleware, cleanBody, deleteOrder);

module.exports = router;
