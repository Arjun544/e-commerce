const Notification = require("../models/Notification");
const cloudinary = require("cloudinary").v2;
const mongoose = require("mongoose");
const User = require("../models/User");
const { admin } = require("../config/firebase-config");
const notificationService = require("../services/notification_service");

exports.sendNotification = async (req, res) => {
  try {
    const deviceToken = req.body.deviceToken;
    const title = req.body.title;
    const body = req.body.body;

  await notificationService.sendNotification(deviceToken, title, body);

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

exports.notifyAllUsers = async (req, res) => {
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
        { timeout: 60000 },
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

exports.saveToken = async (req, res) => {
  const { token } = req.query;
  const { id } = req.body;

  if (!token || !id) {
    return res.json("All fields are required");
  }

  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid user id");
    }
    await User.findByIdAndUpdate(
      id,
      {
        $push: {
          deviceTokens: token,
        },
      },

      { new: true }
    );

    res.send({
      success: true,
      message: "Token saved successfully",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.deleteToken = async (req, res) => {
  const { token } = req.query;
  const { id } = req.body;

  if (!token || !id) {
    return res.json("All fields are required");
  }

  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid user id");
    }
    await User.findByIdAndUpdate(
      id,
      {
        $pull: {
          deviceTokens: token,
        },
      },

      { new: true }
    );

    res.send({
      success: true,
      message: "Token removed successfully",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};
