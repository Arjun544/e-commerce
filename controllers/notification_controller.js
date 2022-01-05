const Notification = require("../models/Notification");
const { admin } = require("../config/firebase-config");
const cloudinary = require("cloudinary");

exports.sendFirebaseNotification = async (req, res) => {
  const notification_options = {
    priority: "high",
    timeToLive: 60 * 60 * 24,
  };
  try {
    const deviceToken = req.body.deviceToken;
    const title = req.body.title;
    const body = req.body.body;
    const options = notification_options;

    const payload = {
      notification: {
        title,
        body,
      },
      // NOTE: The 'data' object is inside payload, not inside notification
      data: {
        image:
          "https://cdn.vox-cdn.com/thumbor/Pkmq1nm3skO0-j693JTMd7RL0Zk=/0x0:2012x1341/1200x800/filters:focal(0x0:2012x1341)/cdn.vox-cdn.com/uploads/chorus_image/image/47070706/google2.0.0.jpg",
      },
    };

    await admin.messaging().sendToDevice(deviceToken, payload, options);

    res.send({
      success: true,
      message: "Notification sent successfully",
    });
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.sendToAllUsers = async (req, res) => {
  const notification_options = {
    priority: "high",
    timeToLive: 60 * 60 * 24,
  };
  try {
    const { title, body, image } = req.body;

    if (!title || !body) {
      return res.json("Title or body can't be empty");
    }

    if (image === null) {
      const message = {
        notification: {
          title,
          body,
        },
        topic: "AllUsers",
      };
      await admin.messaging().send(message);
      res.send({
        success: true,
        message: "Notification sent successfully",
      });
    } else {
      const result = await cloudinary.uploader.upload(
        image,
        (error, result) => {
          console.log(result, error);
        }
      );
      const message = {
        notification: {
          title,
          body,
        },
        data: {
          image: result.secure_url,
        },
        topic: "AllUsers",
      };
      await admin.messaging().send(message);
      res.send({
        success: true,
        message: "Notification sent successfully",
      });
    }
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};
