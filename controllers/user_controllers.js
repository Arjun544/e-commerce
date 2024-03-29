const Joi = require("joi");
const User = require("../models/User");
const jwt = require("jsonwebtoken");
const mongoose = require("mongoose");
const Product = require("../models/Product");
const { sendEmail } = require("../helpers/mailer");
const cloudinary = require("cloudinary");
const socket = require("..");
const Cart = require("../models/Cart");
const stripe = require("stripe")(process.env.STRIPE_KEY);

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

    // create customer for stripe payment
    const customer = await stripe.customers.create({
      name: result.value.username,
      description: "My Customer for SellCorner",
    });

    const newUser = new User(result.value);
    await newUser.save();

    const userCart = await User.find({ email: result.value.email });

    const cart = new Cart({
      user: userCart[0],
      products: [],
    });
    await cart.save();

    await User.findByIdAndUpdate(userCart[0]._id, {
      $set: { customerId: customer.id },
    });

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
    // if (!user.active) {
    //    res.status(400).json({
    //     error: true,
    //     message: "You must verify your email to login",
    //   });
    // }

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
      process.env.ACCESS_JWT_SECRET
    );
    await user.save();

    //Success
    return res.json({
      success: true,
      isActive: user.active,
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
        return res.json({
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
      return res.json({
        status: 400,
        error: true,
        message: "All fields are required",
      });
    }
    const user = await User.findOne({
      email: email,
    });
    if (!user) {
      return res.json({
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

    return res.json({
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
      return res.json({
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

    return res.json({
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

exports.sendCode = async (req, res) => {
  try {
    let code = Math.floor(100000 + Math.random() * 900000); //Generate random 6 digit code.
    let expiry = Date.now() + 60 * 1000 * 10; //Set expiry 10 mins ahead from now

    const sendCode = await sendEmail(req.body.email, code);

    if (sendCode.error) {
      return res.status(500).json({
        error: true,
        message: "Couldn't send verification email.",
      });
    }
    await User.findOneAndUpdate(
      { email: req.body.email },
      {
        $set: {
          emailToken: code,
          emailTokenExpires: new Date(expiry),
        },
      }
    );
    return res.status(200).json({
      message: "Code has been sent",
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
    var query = {};
    var options = {
      select:
        "-resetPasswordToken -resetPasswordExpires -emailToken -emailTokenExpires -password",
      sort: { createdAt: -1 },
      page: req.query.page ?? 1,
      limit: req.query.limit ?? 10,
      pagination: req.query.pagination === "true" ? true : false,
    };
    await User.paginate(query, options, function (err, result) {
      if (err) {
        return res.status(500).json({ error: true, message: err.message });
      } else {
        return res.json({
          page: result.page,
          hasNextPage: result.hasNextPage,
          hasPrevPage: result.hasPrevPage,
          total_pages: result.totalPages,
          total_results: result.totalDocs,
          results: result.docs,
        });
      }
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
  res.json({
    userCount: userCount,
  });
};

// @desc    Get user by id
// @access  Public
exports.getUserById = async (req, res) => {
  try {
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
    return res.json("Password can't be updated here");
  }
  const user = await User.findByIdAndUpdate(
    req.params.id,
    { $set: req.body },
    { new: true }
  );

  if (!user) return res.status(400).send("User not found");

  res.json("Updated");
};

exports.updateImage = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid user id");
    }

    if (!req.body.image || !req.params.id) {
      return res.json("All fields are required");
    }

    // Upload image to cloudinary
    const result = await cloudinary.uploader.upload(req.body.image);

    const user = await User.findByIdAndUpdate(
      req.params.id,
      { $set: { profile: result.secure_url, profileId: result.public_id } },
      { new: true }
    );

    if (!user) return res.status(400).send("User not found");

    res.json("Updated");
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
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
            id: mongoose.Types.ObjectId(),
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

    return res.json("Address has been added");
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.editShippingAddress = async (req, res) => {
  try {
    const { id, address, city, country, type, phone } = req.body;

    if (!id || !address || !city || !country || !type || !phone) {
      return res.json({ error: true, message: "All fields are required" });
    }

    await User.updateOne(
      {
        _id: req.params.id,
        "ShippingAddress.id": mongoose.Types.ObjectId(id),
      },
      {
        $set: {
          "ShippingAddress.$.address": address,
          "ShippingAddress.$.city": city,
          "ShippingAddress.$.country": country,
          "ShippingAddress.$.phone": phone,
          "ShippingAddress.$.type": type,
        },
      }
    );
    return res.json("Address has been edited");
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.removeAddress = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid user id");
    }
    const { id } = req.body;

    await User.findByIdAndUpdate(
      req.params.id,
      {
        $pull: {
          ShippingAddress: {
            id: mongoose.Types.ObjectId(id),
          },
        },
      },

      { new: true }
    );

    return res.json("Address has been removed");
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

// @desc    Delete user
// @access  Public

exports.deleteUserById = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid user id");
    }

    if (!req.body.profileId) {
      return res
        .status(500)
        .json({ success: false, message: "All fields are required" });
    }

    // delete image
    await cloudinary.uploader.destroy(req.body.profileId);

    const user = await User.findByIdAndRemove(req.params.id);
    if (!user) {
      res.status(403).send({ success: false, msg: "User not found" });
    } else {
      return res.status(200).json({
        success: true,
        message: "Deleted user",
      });
    }

    const users = await User.find().select(
      "-resetPasswordToken -resetPasswordExpires -emailToken -emailTokenExpires -password"
    );
    socket.socket.emit("delete-user", users);
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

exports.getWishlist = async (req, res) => {
  const ids = req.body.ids;
  // const products = await Product.find({ _id: { $in: ids } }).populate(
  //   "category"
  // );

  // if (!products) {
  //   return res.status(400).send("Nothing in wishlist");
  // } else {
  //   return res.status(200).json( products );
  // }

  try {
    var query = {
      status: true,
      _id: { $in: ids },
    };
    var options = {
      sort: { dateCreated: -1 },
      page: req.query.page ?? 1,
      limit: req.query.limit ?? 10,
      populate: "category",
    };
    await Product.paginate(query, options, function (err, result) {
      if (err) {
        return res.status(500).json({ error: true, message: err.message });
      } else {
        return res.json({
          page: result.page,
          hasNextPage: result.hasNextPage,
          hasPrevPage: result.hasPrevPage,
          total_pages: result.totalPages,
          total_results: result.totalDocs,
          results: result.docs,
        });
      }
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};
