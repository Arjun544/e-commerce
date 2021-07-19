const multer = require("multer");
const cloudinary = require("cloudinary").v2;
const { CloudinaryStorage } = require("multer-storage-cloudinary");

const storage = new CloudinaryStorage({
  folder: "Product Images",
  allowedFormats: ["jpg", "png"],
  transformation: [
    {
      width: 200,
      height: 200,
      crop: "limit",
    },
  ],
  cloudinary: cloudinary,
});

module.exports = multer({ storage: storage });
