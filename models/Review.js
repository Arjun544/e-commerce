const mongoose = require("mongoose");

const reviewSchema = mongoose.Schema({
  user: {
    type: String,
  },
  review: {
    type: String,
    required: true,
  },
  number: {
    type: Number,
    default: 1,
  },
  addedAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model("review", reviewSchema);
