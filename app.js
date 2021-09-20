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
const adminRoutes = require("./routes/admin_routes");

const connectDB = require("./config/db_config");
const isAuthenticated = require("./middlewares/isAuthenticated");
const authError = require("./middlewares/authError");

const PORT = process.env.PORT || 3000;
require("dotenv").config();

// Db Connection
connectDB();

// Event Emitter
const eventEmitter = new Emitter();
app.set("eventEmitter", eventEmitter);

//Middlewares
app.use(express.urlencoded({ extended: true }));
app.use(express.json()); // To parse the incoming requests with JSON payloads
app.use(isAuthenticated());
app.use(authError);
app.use(cookieParser());
const corsOptions = {
  origin: ["http://localhost:3000"],
  credentials: true,
};

app.use(cors(corsOptions));

// Api Routes
app.use("/api/users/", userRoutes);
app.use("/api/categories/", categoriesRoutes);
app.use("/api/products/", productsRoutes);
app.use("/api/orders/", ordersRoutes);
app.use("/api/cart/", cartRoutes);
app.use("/api/payment/", paymentRoutes);
app.use("/api/admin/", adminRoutes);

//Listening to port
const server = app.listen(PORT, console.log(`Listening on port ${PORT}.`));

const io = require("socket.io")(server);
io.on("connection", (socket) => {
  console.log("socket server is connected");
  socket.on("updatedCart", (productId) => {
    console.log(productId);
    socket.join(productId);
  });
});

eventEmitter.on("updatedCart", (data) => {
  io.to(`product_${data.id}`).emit("updatedCart", data);
});
