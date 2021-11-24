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
      return res.send("No user found");
    }

    const newProduct = await Product.findById(req.body.productId);
    if (!newProduct) {
      return res.send("No product found");
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
    res.send({
      success: true,
      message: "Review has been added",
    });
  } catch (error) {
    console.log(error);
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

    res.send({
      success: true,
      message: "Review has been skipped",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.getAllReviews = async (req, res) => {
  try {
    const totalReviews = await Review.find();
    res.send({
      success: true,
      reviews: totalReviews,
    });
  } catch (error) {
    console.log(error);
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

    res.send({ filteredReviews });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};
