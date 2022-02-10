const mongoose = require("mongoose");
const mongoosePaginate = require("mongoose-paginate-v2");

const orderSchema = mongoose.Schema({
  orderItems: [
    {
      type: Object,
    },
  ],
  shippingAddress: {
    type: String,
    required: true,
  },
  city: {
    type: String,
    required: true,
  },
  country: {
    type: String,
    required: true,
  },
  phone: {
    type: String,
    required: true,
  },
  status: {
    type: String,
    required: true,
    default: "Pending",
  },
  payment: {
    type: String,
    required: true,
  },
  deliveryType: {
    type: String,
    required: true,
  },
  isPaid: {
    type: Boolean,
    default: false,
  },
  totalPrice: {
    type: Number,
  },
  deliveryFee: {
    type: Number,
  },
  user: {
    type: Object,
    required: true,
  },
  dateOrdered: {
    type: Date,
    default: Date.now,
  },
});

orderSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

orderSchema.set("toJSON", {
  virtuals: true,
});

orderSchema.plugin(mongoosePaginate);

module.exports = mongoose.model("Order", orderSchema);
