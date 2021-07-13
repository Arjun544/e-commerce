function authError(err, req, res, next) {
  if (err.name === "UnauthorizedError") {
    // jwt authentication error
    return res.status(401).json({ message: "Only admin has access" });
  }

  if (err.name === "ValidationError") {
    //  validation error
    return res.status(401).json({ message: err });
  }

  // default to 500 server error
  return res.status(500).json(err);
}

module.exports = authError;
