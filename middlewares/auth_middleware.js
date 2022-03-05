const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
  const token = req.headers.cookie;
  if (token == null) return res.sendStatus(401);
  if (!authHeader) {
    return res.json({
      status: false,
      msg: "Unauthorized",
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
