const mongoose = require("mongoose");

const dealSchema = mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  status: {
    type: Boolean,
    default: false,
  },
  products: [
    {
      type: Object,
    },
  ],
});

dealSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

dealSchema.set("toJSON", {
  virtuals: true,
});

module.exports = mongoose.model("Deal", dealSchema);
