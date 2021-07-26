const expressJwt = require("express-jwt");

function isAuthenticated() {
  const secret = process.env.SECRET;

  return expressJwt({
    secret,
    algorithms: ["HS256"],
    isRevoked: isRevoked,
  }).unless({
    path: [
      {
        url: /\/api\/products(.*)/,
        methods: ["GET", "OPTIONS", "PATCH"],
      },
      { url: /\/api\/categories(.*)/, methods: ["GET", "OPTIONS"] },
      { url: /\/api\/orders(.*)/, methods: ["GET", "OPTIONS", "POST"] },
      {
        url: /\/api\/users(.*)/,
        methods: ["GET", "OPTIONS", "PATCH", "POST"],
      },
      {
        url: /\/api\/cart(.*)/,
        methods: ["GET", "OPTIONS", "PATCH", "POST", "DELETE"],
      },
      "/api/users/login",
      "/api/users/register",
      "/api/users/activate",
      "/api/users/allUsers",
    ],
  });
}

async function isRevoked(req, payload, done) {
  if (!payload.isAdmin) {
    done(null, true);
  }

  done();
}

module.exports = isAuthenticated;
