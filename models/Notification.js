const mongoose = require("mongoose");

const notificationSchema = mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  body: {
    type: String,
    required: true,
  },
  type: {
    type: String,
    required: true,
  },
  hasRead: {
    type: Boolean,
    default: false,
  },
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

notificationSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

notificationSchema.set("toJSON", {
  virtuals: true,
});

module.exports = mongoose.model("Notification", notificationSchema);
