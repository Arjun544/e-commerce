const Joi = require("joi");
const User = require("../models/User");
const jwt = require("jsonwebtoken");
const mongoose = require("mongoose");
const Product = require("../models/Product");
const { sendEmail } = require("../helpers/mailer");
const cloudinary = require("cloudinary");

const userSchema = Joi.object().keys({
  username: Joi.string().required().min(2),
  email: Joi.string().email({ minDomainSegments: 2 }),
  password: Joi.string().required().min(8),
  confirmPassword: Joi.any()
    .equal(Joi.ref("password"))
    .required()
    .label("Confirm password")
    .messages({ "any.only": "{{#label}} does not match" }),
});

exports.register = async (req, res) => {
  try {
    const result = userSchema.validate(req.body);
    if (result.error) {
      return res.json({
        error: true,
        status: 400,
        message: result.error.message,
      });
    }

    //Check if the email has been already registered.
    var user = await User.findOne({
      email: result.value.email,
    });

    if (user) {
      return res.json({
        error: true,
        message: "Email is already in use",
      });
    }

    const hash = await User.hashPassword(result.value.password);

    //remove the confirmPassword field from the result as we dont need to save this in the db.
    delete result.value.confirmPassword;
    result.value.password = hash;

    let code = Math.floor(100000 + Math.random() * 900000); //Generate random 6 digit code.
    let expiry = Date.now() + 60 * 1000 * 10; //Set expiry 10 mins ahead from now

    const sendCode = await sendEmail(result.value.email, code);

    if (sendCode.error) {
      return res.status(500).json({
        error: true,
        message: "Couldn't send verification email.",
      });
    }
    result.value.emailToken = code;
    result.value.emailTokenExpires = new Date(expiry);

    const newUser = new User(result.value);
    await newUser.save();

    return res.status(200).json({
      success: true,
      message: "Registration Success",
    });
  } catch (error) {
    return res.status(500).json({
      error: true,
      message: "Cannot Register",
    });
  }
};

// @desc    Get login User
// @access  Public
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
    const user = await User.findOne({ email: email });

    // NOT FOUND - Throw error
    if (!user) {
      return res.status(404).json({
        error: true,
        message: "Account not found",
      });
    }

    //2. Throw error if account is not activated
    if (!user.active) {
      return res.status(400).json({
        error: true,
        message: "You must verify your email to login",
      });
    }

    //3. Verify the password is valid
    const isValid = await User.comparePasswords(password, user.password);

    if (!isValid) {
      return res.status(400).json({
        error: true,
        message: "Invalid credentials",
      });
    }
    let token = jwt.sign(
      {
        userId: user.id,
        isAdmin: user.isAdmin,
      },
      process.env.JWT_SECRET,
      {}
    );
    await user.save();

    //Success
    return res.json({
      success: true,
      token: token,
      userId: user.id,
      message: "User logged in successfully",
    });
  } catch (err) {
    return res.status(500).json({
      error: true,
      message: "Couldn't login. Please try again later.",
    });
  }
};

// @desc    Activite account
// @access  Public
exports.activate = async (req, res) => {
  try {
    const { email, code } = req.body;
    if (!email || !code) {
      return res.json({
        error: true,
        status: 400,
        message: "All fields are required",
      });
    }
    const user = await User.findOne({
      email: email,
      emailToken: code,
      emailTokenExpires: { $gt: Date.now() }, // check if the code is expired
    });

    if (!user) {
      return res.status(400).json({
        error: true,
        message: "Invalid details",
      });
    } else {
      if (user.active)
        return res.send({
          error: true,
          message: "Account already activated",
          status: 400,
        });

      user.emailToken = "";
      user.emailTokenExpires = null;
      user.active = true;

      await user.save();

      return res.status(200).json({
        success: true,
        message: "Account activated.",
      });
    }
  } catch (error) {
    return res.status(500).json({
      error: true,
      message: error.message,
    });
  }
};

exports.forgotPassword = async (req, res) => {
  try {
    const { email } = req.body;
    if (!email) {
      return res.send({
        status: 400,
        error: true,
        message: "All fields are required",
      });
    }
    const user = await User.findOne({
      email: email,
    });
    if (!user) {
      return res.send({
        success: true,
        message: "User not found",
      });
    }

    let code = Math.floor(100000 + Math.random() * 900000);
    let response = await sendEmail(user.email, code);

    if (response.error) {
      return res.status(500).json({
        error: true,
        message: "Couldn't send mail. Please try again later.",
      });
    }

    let expiry = Date.now() + 60 * 1000 * 10;
    user.resetPasswordToken = code;
    user.resetPasswordExpires = expiry; // 10 minutes

    await user.save();

    return res.send({
      success: true,
      message:
        "If that email address is in our database, we will send you an email to reset your password",
    });
  } catch (error) {
    return res.status(500).json({
      error: true,
      message: error.message,
    });
  }
};

exports.resetPassword = async (req, res) => {
  try {
    const { token, newPassword, confirmPassword } = req.body;
    if (!token || !newPassword || !confirmPassword) {
      return res.status(403).json({
        error: true,
        message: "All fields are required",
      });
    }
    const user = await User.findOne({
      resetPasswordToken: req.body.token,
      resetPasswordExpires: { $gt: Date.now() },
    });
    if (!user) {
      return res.send({
        error: true,
        message: "Password reset token is invalid or has expired.",
      });
    }
    if (newPassword !== confirmPassword) {
      return res.status(400).json({
        error: true,
        message: "Passwords didn't match",
      });
    }
    const hash = await User.hashPassword(req.body.newPassword);
    user.password = hash;
    user.resetPasswordToken = null;
    user.resetPasswordExpires = "";

    await user.save();

    return res.send({
      success: true,
      message: "Password has been changed",
    });
  } catch (error) {
    console.error("reset-password-error", error);
    return res.status(500).json({
      error: true,
      message: error.message,
    });
  }
};

// @desc    Get all users
// @route   GET /user/login
// @access  Public
exports.getAllUsers = async (req, res) => {
  try {
    const user = await User.find().select(
      "-resetPasswordToken -resetPasswordExpires -emailToken -emailTokenExpires -password"
    );
    res.status(200).json({
      success: true,
      count: user.length,
      data: user,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

// @desc    Get users count
// @access  Public
exports.count = async (req, res) => {
  const userCount = await User.countDocuments((count) => count);

  if (!userCount) {
    res.status(500).json({ success: false });
  }
  res.send({
    userCount: userCount,
  });
};

// @desc    Get user by id
// @access  Public
exports.getUserById = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid user id");
    }

    const user = await User.findById(req.params.id).select(
      "-resetPasswordToken -resetPasswordExpires -emailToken -emailTokenExpires -password -isAdmin -updatedAt -v -dataId -createdAt -__v"
    );
    if (!user || !user.active) {
      res.status(403).send({ success: false, msg: "User not found" });
    } else {
      return res.status(200).json({
        success: true,
        data: user,
      });
    }
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

// @desc    Update user
// @access  Public
exports.updateUser = async (req, res) => {
  if (!mongoose.isValidObjectId(req.params.id)) {
    return res.status(400).send("Invalid user id");
  }
  // update only those value passed from req.body, but not password
  if (req.body.password) {
    return res.send("Password can't be updated here");
  }
  const user = await User.findByIdAndUpdate(
    req.params.id,
    { $set: req.body },
    { new: true }
  );

  if (!user) return res.status(400).send("User not found");

  res.send("Updated");
};

exports.updateImage = async (req, res) => {
  if (!mongoose.isValidObjectId(req.params.id)) {
    return res.status(400).send("Invalid user id");
  }
  // update only those value passed from req.body, but not password
  if (!req.file) {
    return res.send("ImageUrl is required");
  }

  // Upload image to cloudinary
  const result = await cloudinary.uploader.upload(req.file.path);

  const user = await User.findByIdAndUpdate(
    req.params.id,
    { $set: { profile: result.secure_url } },
    { new: true }
  );

  if (!user) return res.status(400).send("User not found");

  res.send("Updated");
};

exports.addShippingAddress = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid user id");
    }
    const { address, city, country, type, phone } = req.body;

    if (!address || !city || !country || !type || !phone) {
      return res.json({ error: true, message: "All fields are required" });
    }

    await User.findByIdAndUpdate(
      req.params.id,
      {
        $push: {
          ShippingAddress: {
            address: address,
            city: city,
            country: country,
            phone: phone,
            type: type,
          },
        },
      },

      { new: true }
    );

    return res.send('Address has been added');
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

// @desc    Delete post
// @access  Public

exports.deleteUserById = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid user id");
    }

    const user = await User.findByIdAndRemove(req.params.id);
    if (!user) {
      res.status(403).send({ success: false, msg: "User not found" });
    } else {
      return res.status(200).json({
        success: true,
        message: "Deleted user",
      });
    }
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

exports.getWishlist = async (req, res) => {
  try {
    const ids = req.body.ids;
    const products = await Product.find({ _id: { $in: ids } });

    if (!products) {
      return res.status(400).send("Nothing in wishlist");
    } else {
      return res.status(200).json({ products });
    }
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

exports.clearWishlist = async (req, res) => {
  try {
    if (!req.params.userId) {
      return res.status(400).send("User id is required");
    }
    const user = await User.findByIdAndUpdate(
      { _id: req.params.userId },
      {
        $push: {
          wishlist: [],
        },
      }
    );

    if (!user) {
      return res.status(400).send("User not found");
    } else {
      return res.status(200).json("Wishlist is cleared");
    }
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};
