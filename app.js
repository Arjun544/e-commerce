const express = require("express");
const app = express();

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

const io = require('socket.io')(server);

io.on('onnection', (sokcet) => {
    console.log('socket server is connected');
    socket.on("test", (data) => {
        console.log(data);
    });
})
