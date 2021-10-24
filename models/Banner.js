const mongoose = require("mongoose");

const bannerSchema = mongoose.Schema(
  {
    title: {
      type: String,
      required: true,
    },
    image: {
      type: String,
      required: true,
    },
    imageId: {
      type: String,
    },
    type: {
      type: String,
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
  },
  { strict: false }
);

bannerSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

bannerSchema.set("toJSON", {
  virtuals: true,
});

module.exports = mongoose.model("Banner", bannerSchema);
