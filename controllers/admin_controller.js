const Admin = require("../models/Admin");
const tokenService = require("../services/token_services");

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
        success: false,
        message: "Invalid credentials",
      });
    }
    const { accessToken } = tokenService.generateTokens({
      _id: admin._id,
      activated: false,
    });

    // res.set("Access-Control-Allow-Origin", req.headers.origin);
    // res.set("Access-Control-Allow-Credentials", "true");
    // res.set(
    //   "Access-Control-Expose-Headers",
    //   "date, etag, access-control-allow-origin, access-control-allow-credentials"
    // );

    // res.cookie("accessToken", accessToken, {
    //   httpOnly: true,
    //   origin : "https://admin-sellcorner.herokuapp.com",
    // });

    await admin.save();
    //Success
    return res.json({
      user: { id: admin.id, profile: admin.profile, email: admin.email },
      auth: true,
      accessToken: accessToken
    });
  } catch (err) {
    return res.status(500).json({
      error: true,
      message: "Couldn't login. Please try again later.",
    });
  }
};

exports.logout = async (req, res) => {
  const { accessToken } = req.cookies;
  // delete refresh token from db
  await tokenService.removeToken(accessToken);
  // delete cookies
  res.clearCookie("accessToken");
  res.json({ user: null, auth: false, accessToken: null});
};
