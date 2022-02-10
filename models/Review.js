const mongoose = require("mongoose");
const mongoosePaginate = require("mongoose-paginate-v2");

const reviewSchema = mongoose.Schema({
  user: {
    type: Object,
  },
  review: {
    type: String,
    required: true,
  },
  rating: {
    type: Number,
    required: true,
    max: 5,
  },
  product: {
    type: Object,
  },
  addedAt: {
    type: Date,
    default: Date.now,
  },
});

reviewSchema.plugin(mongoosePaginate);

module.exports = mongoose.model("Review", reviewSchema);
