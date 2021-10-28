const mongoose = require("mongoose");
const User = require("../models/User");
const Product = require("../models/Product");

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

/**
Order Example:

{
    "cartItems" : [
        {
            "quantity": 3,
            "product" : "5fcfc406ae79b0a6a90d2585"
        },
        {
            "quantity": 2,
            "product" : "5fd293c7d3abe7295b1403c4"
        }
    ],
    "totalPrice": 150,
    "user": "5fd51bc7e39ba856244a3b44"
}

 */
