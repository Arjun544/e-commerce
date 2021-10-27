const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
const authMiddleware = require("../middlewares/auth_middleware");

const {
  addDeal,
  getAdminDeals,
  updateDeal,
  deleteDeal,
  addDealProducts,
  removeDealProduct,
  updateStatus,
} = require("../controllers/deal_controller");

router.post("/add", authMiddleware, cleanBody, addDeal);

router.get("/get", authMiddleware, cleanBody, getAdminDeals);
router.patch("/update/:id", authMiddleware, cleanBody, updateDeal);
router.patch(
  "/updateStatus/:id/:status",
  authMiddleware,
  cleanBody,
  updateStatus
);
router.patch(
  "/addDealProducts/:id",
  authMiddleware,
  cleanBody,
  addDealProducts
);
router.patch(
  "/removeDealProduct/:id",
  authMiddleware,
  cleanBody,
  removeDealProduct
);
router.delete("/delete/:id", authMiddleware, cleanBody, deleteDeal);

module.exports = router;
