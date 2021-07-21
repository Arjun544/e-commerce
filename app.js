const express = require("express");
const app = express();
const Emitter = require("events");

//imports
const userRoutes = require("./routes/user_routes");
const categoriesRoutes = require("./routes/categories_routes");
const productsRoutes = require("./routes/products_routes");
const ordersRoutes = require("./routes/orders_routes");
const cartRoutes = require("./routes/cart_router");
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

// Api Routes
app.use("/api/users/", userRoutes);
app.use("/api/categories/", categoriesRoutes);
app.use("/api/products/", productsRoutes);
app.use("/api/orders/", ordersRoutes);
app.use("/api/cart/", cartRoutes);

//Listening to port
const server = app.listen(PORT, console.log(`Listening on port ${PORT}.`));

const io = require("socket.io")(server);
let socket = null;
io.on("connection", (socket) => {
  console.log("socket server is connected");
  socket = socket;
  socket.on("productQuantity", (productId) => {
    console.log(productId);
    socket.join(productId);
  });

  socket.on("cartTotal", () => {});
});

eventEmitter.on("updatedQuantity", (data) => {
  io.to(`product_${data.id}`).emit("updatedQuantity", data.quantity);
});

eventEmitter.on("updatedTotal", (totalGrand) => {
  console.log(`total ${totalGrand}`)
  socket.emit("updatedTotal", totalGrand);
});
