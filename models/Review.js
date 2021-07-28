const mongoose = require("mongoose");

const reviewSchema = mongoose.Schema({
  addedAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model("review", reviewSchema);
