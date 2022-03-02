const { admin } = require("../config/firebase-config");
class NotificationService {
  async sendNotification(tokens, title, body) {
    const options = {
      priority: "high",
      timeToLive: 60 * 60 * 24,
    };
    const payload = {
      notification: {
        title,
        body,
      },
    };
    return await admin.messaging().sendToDevice(tokens, payload, options);
  }
}

module.exports = new NotificationService();
