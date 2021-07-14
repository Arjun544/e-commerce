const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");

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

router.post("/add", cleanBody, addOrder);
router.get("/get", cleanBody, getOrders);
router.get("/totalsales", cleanBody, totalSales);
router.get("/count", cleanBody, count);
router.get("/userOrders/:id", cleanBody, userOrders);
router.get("/:id", cleanBody, getOrderById);
router.patch("/:id", cleanBody, updateStatus);
router.delete("/:id", cleanBody, deleteOrder);

module.exports = router;
