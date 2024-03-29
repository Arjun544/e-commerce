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
const reviewsRoutes = require("./routes/reviews_routes");
const adminRoutes = require("./routes/admin_routes");
const notificationRoutes = require("./routes/notification_routes");

const server = require("http").createServer(app);

// Sooket Connection
const io = require("socket.io")(server, {
  cors: {
    origin: "https://e-commerce-arjun544.vercel.app",
    methods: ["GET", "POST", "PUT", "DELETE"],
  },
});

const connectDB = require("./config/db_config");
  
const PORT = process.env.PORT || 4000;
require("dotenv").config();

// Db Connection
connectDB();

app.set("trust proxy", 1);
// Event Emitter
const eventEmitter = new Emitter();
app.set("eventEmitter", eventEmitter);
//Middlewares
app.use(
  cors({
    origin: ["https://e-commerce-arjun544.vercel.app"],
  })
);
app.use(express.urlencoded({ extended: true }));
app.use(express.json({ limit: "50mb" }));
app.use(cookieParser());

// Api Routes
app.use("/api/users/", userRoutes);
app.use("/api/categories/", categoriesRoutes);
app.use("/api/products/", productsRoutes);
app.use("/api/orders/", ordersRoutes);
app.use("/api/cart/", cartRoutes);
app.use("/api/banners/", bannersRoutes);
app.use("/api/payment/", paymentRoutes);
app.use("/api/reviews/", reviewsRoutes);
app.use("/api/admin/", adminRoutes);
app.use("/api/notification/", notificationRoutes);

const socket = io.on("connection", (socket) => {
  console.log("socket server is connected");
  return socket;
});

module.exports.socket = socket;

eventEmitter.on("updatedCart", (data) => {
  io.to(`product_${data.id}`).emit("updatedCart", data);
});

//Listening to port
server.listen(PORT, console.log(`Listening on port ${PORT}.`));
