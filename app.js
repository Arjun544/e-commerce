const express = require("express");
const app = express();

//imports
const userRoutes = require("./routes/user_routes");
const categoriesRoutes = require("./routes/categories_routes");
const productsRoutes = require("./routes/products_routes");
const ordersRoutes = require("./routes/orders_routes");
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
app.use("/public/uploads", express.static(__dirname + "/public/uploads"));
app.use(authError);

// Api Routes
app.use("/api/users/", userRoutes);
app.use("/api/categories/", categoriesRoutes);
app.use("/api/products/", productsRoutes);
app.use("/api/orders/", ordersRoutes);

//Listening to port
app.listen(PORT, console.log(`Listening on port ${PORT}.`));