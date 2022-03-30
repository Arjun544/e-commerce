const socket = require("../app");
const mongoose = require("mongoose");
var ObjectID = require("mongodb").ObjectID;
const Review = require("../models/Review");
const Product = require("../models/Product");
const User = require("../models/User");
const Order = require("../models/Order");

exports.addReview = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid product id");
    }

    const { userId, review, rating } = req.body;
    if (!userId || !rating) {
      res.json("All fields are required");
    } else if (review.length < 3) {
      res.json("Review length can't be less than 3");
    }
    const newUser = await User.findById(userId).select(
      "-resetPasswordToken -resetPasswordExpires -emailToken -emailTokenExpires -password"
    );
    if (!newUser) {
      return res.json("No user found");
    }

    const newProduct = await Product.findById(req.body.productId);
    if (!newProduct) {
      return res.json("No product found");
    }

    const newReview = new Review({
      user: newUser,
      review: review,
      rating: rating,
      product: newProduct,
      addedAt: Date.now(),
    });
    await newReview.save();

    await Product.findByIdAndUpdate(req.body.productId, {
      $inc: { totalReviews: 1 },
      $push: {
        reviews: newReview,
      },
    });
    // update in specific product of order
    await Order.updateOne(
      {
        _id: req.params.id,
        "orderItems.id": req.body.productId,
      },
      {
        $set: {
          "orderItems.$.isReviewed": true,
        },
        $inc: { totalReviews: 1 },
        $push: {
          reviews: newReview,
        },
      }
    );
    res.json({
      success: true,
      message: "Review has been added",
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.skipReview = async (req, res) => {
  try {
    await Order.updateOne(
      {
        _id: req.params.id,
        "orderItems.id": req.body.productId,
      },
      {
        $set: {
          "orderItems.$.isReviewed": true,
        },
      }
    );

    res.json({
      success: true,
      message: "Review has been skipped",
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.getAllReviews = async (req, res) => {
  try {
    var query = {};
    var options = {
      sort: { addedAt: -1 },
      page: req.query.page ?? 1,
      limit: req.query.limit ?? 10,
      pagination: req.query.pagination === "true" ? true : false,
    };
    await Review.paginate(query, options, function (err, result) {
      if (err) {
        return res.status(500).json({ error: true, message: err.message });
      } else {
        return res.json({
          page: result.page,
          hasNextPage: result.hasNextPage,
          hasPrevPage: result.hasPrevPage,
          total_pages: result.totalPages,
          total_results: result.totalDocs,
          results: result.docs,
        });
      }
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.getRecentReviews = async (req, res) => {
  try {
    const currrentDate = new Date().toISOString().split("T")[0];
    const totalReviews = await Review.find();
    const filteredReviews = totalReviews.filter(
      (item) => item.addedAt.toISOString().split("T")[0] === currrentDate
    );

    res.json({ filteredReviews });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};
