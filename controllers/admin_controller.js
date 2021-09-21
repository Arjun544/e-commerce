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
    const { accessToken, refreshToken } = tokenService.generateTokens({
      _id: admin._id,
      activated: false,
    });
    await tokenService.storeRefreshToken(refreshToken, admin._id);

    res.cookie("refreshToken", refreshToken, {
      maxAge: 1000 * 60 * 60 * 24 * 30,
      httpOnly: true,
    });

    res.cookie("accessToken", accessToken, {
      maxAge: 1000 * 60 * 60 * 24 * 30,
      httpOnly: false,
    });

    await admin.save();
    //Success
    return res.json({
      user: admin,
      auth: false,
    });
  } catch (err) {
    return res.status(500).json({
      error: true,
      message: "Couldn't login. Please try again later.",
    });
  }
};

exports.refreshToken = async (req, res) => {
  // get refresh token from cookie
  const { refreshToken: refreshTokenFromCookie } = req.cookies;
  // check if token is valid
  let userData;
  try {
    userData = await tokenService.verifyRefreshToken(refreshTokenFromCookie);
  } catch (err) {
    return res.status(401).json({ message: "Invalid Token" });
  }
  // Check if token is in db
  try {
    const token = await tokenService.findRefreshToken(
      userData._id,
      refreshTokenFromCookie
    );
    if (!token) {
      return res.status(401).json({ message: "Invalid token" });
    }
  } catch (err) {
    return res.status(500).json({ message: "Internal error" });
  }
  // check if valid user
  const user = await Admin.findOne({ _id: userData._id });
  if (!user) {
    return res.status(404).json({ message: "No user" });
  }
  // Generate new tokens
  const { refreshToken, accessToken } = tokenService.generateTokens({
    _id: userData._id,
  });

  // Update refresh token
  try {
    await tokenService.updateRefreshToken(userData._id, refreshToken);
  } catch (err) {
    return res.status(500).json({ message: "Internal error" });
  }
  // put in cookie
  res.cookie("refreshToken", refreshToken, {
    maxAge: 1000 * 60 * 60 * 24 * 30,
    httpOnly: false,
  });

  res.cookie("accessToken", accessToken, {
    maxAge: 1000 * 60 * 60 * 24 * 30,
    httpOnly: false,
  });
  // response
  res.json({ user: user, auth: true });
};

exports.logout = async (req, res) => {
  const { refreshToken } = req.cookies;
  // delete refresh token from db
  await tokenService.removeToken(refreshToken);
  // delete cookies
  res.clearCookie("refreshToken");
  res.clearCookie("accessToken");
  res.json({ user: null, auth: false });
};
