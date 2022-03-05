const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
  const token = req.headers.cookie;
  if (!token) {
    return res.json({
      status: false,
      msg: "Please provide an access token",
    });
  }

  jwt.verify(
    token.split("=")[1],
    process.env.ACCESS_JWT_SECRET,
    (err, user) => {
      if (err) {
        return res.json({
          status: false,
          msg: "Unauthorized",
        });
      }
      req.user = user;
      next();
    }
  );
};
