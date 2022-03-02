const { admin } = require("../config/firebase-config");
class NotificationService {
  async sendNotification(tokens, title, body, type, orderId = "1") {
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
}

module.exports = new NotificationService();
