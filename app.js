const express = require("express");
const app = express();
const Emitter = require("events");
const cors = require("cors");
const cookieParser = require("cookie-parser");

//imports
const userRoutes = require("./routes/user_routes");
const categoriesRoutes = require("./routes/categories_routes");
const productsRoutes = require("./routes/products_routes");
const ordersRoutes = require("./routes/orders_routes");
const cartRoutes = require("./routes/cart_router");
const paymentRoutes = require("./routes/payment_routes");
const bannersRoutes = require("./routes/banner_routes");
const dealRoutes = require("./routes/deal_routes");
const reviewsRoutes = require("./routes/reviews_routes");
const adminRoutes = require("./routes/admin_routes");
const notificationRoutes = require("./routes/notification_routes");

const server = require("http").createServer(app);

// Sooket Connection
const io = require("socket.io")(server, {
  transports: ["polling"],
  autoConnect: true,
  cors: {
    origin: [
      "http://localhost:3000",
      "http://192.168.0.101:4000",
      "http://192.168.0.149:4000",
      "https://sellcorner-admin.herokuapp.com",
    ],
    methods: ["GET", "POST", "PUT", "DELETE"],
  },
});

const connectDB = require("./config/db_config");

const PORT = process.env.PORT || 4000;
require("dotenv").config();

// Db Connection
connectDB();

// Event Emitter
const eventEmitter = new Emitter();
app.set("eventEmitter", eventEmitter);
app.set("trust proxy", 1);
//Middlewares
app.use(
  cors({
    credentials: true,
    methods: "GET, POST, PUT, DELETE",
    origin: ["http://localhost:3000", "https://sellcorner-admin.herokuapp.com"],
  })
);
app.use(express.urlencoded({ extended: true }));
app.use(express.json({ limit: "50mb" }));
app.use(cookieParser());
app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Credentials", true);
  res.header(
    "Access-Control-Allow-Origin",
    "https://sellcorner-admin.herokuapp.com"
  );
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept, Authorization, X-HTTP-Method-Override, Set-Cookie, Cookie"
  );
  res.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE");
  next();
});

// Api Routes
app.use("/api/users/", userRoutes);
app.use("/api/categories/", categoriesRoutes);
app.use("/api/products/", productsRoutes);
app.use("/api/orders/", ordersRoutes);
app.use("/api/cart/", cartRoutes);
app.use("/api/banners/", bannersRoutes);
app.use("/api/deal/", dealRoutes);
app.use("/api/payment/", paymentRoutes);
app.use("/api/reviews/", reviewsRoutes);
app.use("/api/admin/", adminRoutes);
app.use("/api/notification/", notificationRoutes);

const socket = io.on("connection", (socket) => {
  console.log("socket server is connected");
  socket.on("updatedCart", (productId) => {
    socket.join(productId);
  });
  return socket;
});

module.exports.socket = socket;

eventEmitter.on("updatedCart", (data) => {
  io.to(`product_${data.id}`).emit("updatedCart", data);
});

//Listening to port
server.listen(PORT, console.log(`Listening on port ${PORT}.`));
