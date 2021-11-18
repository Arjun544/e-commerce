const { number } = require("joi");
const mongoose = require("mongoose");
const mongoose_fuzzy_searching = require("mongoose-fuzzy-searching");

const productSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  quantity: {
    type: Number,
    default: 1,
  },
  description: {
    type: String,
    required: true,
  },
  fullDescription: {
    type: String,
    default: "",
  },
  thumbnail: {
    type: String,
  },
  thumbnailId: {
    type: String,
  },
  images: {
    type: Array,
    default: [],
  },
  price: {
    type: Number,
    default: 0,
    min: 0,
  },
  category: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Category",
    required: true,
  },
  subCategory: {
    type: String,
    required: true,
  },
  countInStock: {
    type: Number,
    required: true,
    min: 0,
    max: 100,
  },
  onSale: {
    type: Boolean,
    default: false,
  },
  totalPrice: {
    type: Number,
    default: 0,
  },
  discount: {
    type: Number,
    default: 0,
    min: 0,
    max: 100,
  },
  price: {
    type: Number,
    default: 0,
    min: 0,
  },
  totalReviews: {
    type: Number,
    default: 0,
  },
  reviews: [
    {
      type: Object,
      default: {},
    },
  ],
  isReviewed: {
    type: Boolean,
    default: false,
  },
  isFeatured: {
    type: Boolean,
    default: false,
  },
  status: {
    type: Boolean,
    default: true,
  },
  dateCreated: {
    type: Date,
    default: Date.now,
  },
});

productSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

productSchema.set("toJSON", {
  virtuals: true,
});

productSchema.plugin(mongoose_fuzzy_searching, {
  fields: ["name"],
});

module.exports = mongoose.model("Product", productSchema);
