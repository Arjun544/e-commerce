const mongoose = require("mongoose");

const connectDB = async () => {
  try {
    mongoose.set("strictQuery", false);
    console.log(process.env.DB_URL);

    mongoose.connect(process.env.DB_URL, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    mongoose.Promise = global.Promise;
    console.log("Connected to DB..!");
  } catch (error) {
    process.exit(1);
  }
};

module.exports = connectDB;
