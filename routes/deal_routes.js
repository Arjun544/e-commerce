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
} = require("../controllers/deal_controller");

router.post("/add", authMiddleware, cleanBody, addDeal);

router.get("/get", authMiddleware, cleanBody, getAdminDeals);
router.patch("/update/:id", authMiddleware, cleanBody, updateDeal);
router.patch(
  "/addDealProducts/:id",
  authMiddleware,
  cleanBody,
  addDealProducts
);
router.delete("/delete/:id", authMiddleware, cleanBody, deleteDeal);

module.exports = router;
