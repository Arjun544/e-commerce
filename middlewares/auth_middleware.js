const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];
  if (token == null) return res.sendStatus(401);
  if (!authHeader) {
    return res.json({
      status: false,
      msg: "Unauthorized",
    });
  }

  jwt.verify(token, process.env.ACCESS_JWT_SECRET, (err, user) => {
    if (err) {
      return res.json({
        status: false,
        msg: "Unauthorized",
      });
    }

    next();
  });
};
