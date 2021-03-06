const { admin } = require("../config/firebase-config");
const Notification = require("../models/Notification");
class NotificationService {
  async sendNotification(tokens, title, body, type, orderId) {
    const options = {
      priority: "high",
      timeToLive: 60 * 60 * 24,
    };
    const payload = {
      notification: {
        title,
        body,
      },
      data: {
        type: type,
        orderId: orderId,
      },
    };
    return await admin.messaging().sendToDevice(tokens, payload, options);
  }

  async saveNotification(title, body, type, userId) {
    const notification = Notification({
      title,
      body,
      type,
      user: userId,
    });
    return await notification.save();
  }
}

module.exports = new NotificationService();
