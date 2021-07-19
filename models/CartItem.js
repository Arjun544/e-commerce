const mongoose = require("mongoose");

const cartItemSchema = mongoose.Schema({
  quantity: {
    type: Number,
    required: true,
    default: 1,
    min: [1, "Quantity can't be less than 1"],
  },
  product: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Product",
  },
  userId: {
    type: String,
    unquie: true,
  },
});

module.exports = mongoose.model("CartItem", cartItemSchema);
