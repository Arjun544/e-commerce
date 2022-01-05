const mongoose = require("mongoose");

const notificationSchema = mongoose.Schema(
  {
    messageId: {
      type: String,
      required: true,
    },
    title: {
      type: String,
      required: true,
    },
    body: {
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
    hasRead: {
      type: Boolean,
      default: false,
    },
    messageId: {
      type: String,
      required: true,
    },
  },
  { strict: false }
);

notificationSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

notificationSchema.set("toJSON", {
  virtuals: true,
});

module.exports = mongoose.model("Notification", notificationSchema);
