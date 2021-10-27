const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
const authMiddleware = require("../middlewares/auth_middleware");

const {
  addReview,
  getAllReviews,
  getRecentReviews,
} = require("../controllers/reviews_controller");

router.post("/add/:id", authMiddleware, cleanBody, addReview);
router.get("/get", authMiddleware, cleanBody, getAllReviews);
router.get("/getRecentReviews", authMiddleware, cleanBody, getRecentReviews);

module.exports = router;
