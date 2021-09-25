const mongoose = require("mongoose");

const categorySchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  subCategories: {
    type: Array,
    default: [],
  },
  icon: {
    type: String,
  },
});

categorySchema.virtual("id").get(function () {
  return this._id.toHexString();
});

categorySchema.set("toJSON", {
  virtuals: true,
});

module.exports = mongoose.model("Category", categorySchema);
