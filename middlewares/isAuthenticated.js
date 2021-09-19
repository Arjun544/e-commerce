const expressJwt = require("express-jwt");

function isAuthenticated() {
  const secret = process.env.SECRET;

  return expressJwt({
    secret,
    algorithms: ["HS256"],
    isRevoked: isRevoked,
  }).unless({
    path: [
      // User routes
      "/api/users/login",
      "/api/users/register",
      "/api/users/activate",
      "/api/users/wishlist",
      "/api/users/forgotPassword",
      "/api/users/resetPassword",
      "/api/users/addAddress",
      "/api/users/editAddress",
      "/api/users/removeAddress",
      "/api/users/updateImage",
      "/api/users/:id",
      "/api/users/update",
      "/api/users/wishlist",

      // Products routes
      "/api/products/addReview",
      "/api/products/get",
      "/api/products/newArrival",
      "/api/products/filterByPrice",
      "/api/products/sorting",
      "/api/products/featured",
      "/api/products/:id",
      "/api/products/search",
      "/api/products/similar",
      "/api/products/byCategory",

      // Orders routes
      "/api/orders/add",
      "/api/orders/userOrders",

      // Categories routes
      "/api/orders/get",

      // Cart routes
      "/api/cart/addToCart",
      "/api/cart/getCart",
      "/api/cart/updateQuantity",
      "/api/cart/:id",
      "/api/cart/clear",

      // Payment routes
      "/api/payment/createCustomer",
      "/api/payment/getCustomerCard",
      "/api/payment/pay",

      // Admin routes
      "/api/admin/login",
      "/api/admin/refresh",
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
