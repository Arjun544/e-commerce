const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
const authMiddleware = require("../middlewares/auth_middleware");

const {
  addReview,
  skipReview,
  getAllReviews,
  getRecentReviews,
} = require("../controllers/reviews_controller");


router.get("/get", authMiddleware, cleanBody, getAllReviews);
router.get("/getRecentReviews", authMiddleware, cleanBody, getRecentReviews);
router.post("/add/:id", authMiddleware, cleanBody, addReview);
router.patch("/skip/:id", authMiddleware, cleanBody, skipReview);


module.exports = router;
