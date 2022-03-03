const mongoose = require("mongoose");
const User = require("../models/User");

const cartSchema = mongoose.Schema({
  products: [
    {
      type: Object,
    },
  ],
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: User,
  },
  dateOrdered: {
    type: Date,
    default: Date.now,
  },
});

cartSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

cartSchema.set("toJSON", {
  virtuals: true,
});

module.exports = mongoose.model("Cart", cartSchema);
