const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
  const token = req.headers.cookie;
  console.log(req.headers.cookie);
  if (!token) res.status(403).json({ error: "please provide a token" });
  else {
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
  }
};
