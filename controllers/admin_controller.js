const Joi = require("joi");
const Admin = require("../models/Admin");
const jwt = require("jsonwebtoken");
const mongoose = require("mongoose");
const cloudinary = require("cloudinary");

exports.logIn = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({
        error: true,
        message: "All fields are required.",
      });
    }

    //1. Find if any account with that email exists in DB
    const admin = await Admin.findOne({ email: email });

    // NOT FOUND - Throw error
    if (!admin) {
      return res.status(404).json({
        error: true,
        message: "Account not found",
      });
    }
    // hashPassword before comparsion
    const hash = await Admin.hashPassword(admin.password);

    //3. Verify the password is valid
    const isValid = await Admin.comparePasswords(password, hash);

    if (!isValid) {
      return res.status(400).json({
        error: true,
        message: "Invalid credentials",
      });
    }
    let token = jwt.sign(
      {
        adminId: admin.id,
      },
      process.env.JWT_SECRET,

      { expiresIn: "1h" }
    );
    await admin.save();

    //Success
    return res.json({
      success: true,
      token: token,
      adminId: admin.id,
      message: "User logged in successfully",
    });
  } catch (err) {
    return res.status(500).json({
      error: true,
      message: "Couldn't login. Please try again later.",
    });
  }
};
