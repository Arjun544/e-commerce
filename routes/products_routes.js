const express = require("express");
const router = express.Router();
const cleanBody = require("../middlewares/cleanBody");
const multer = require("multer");

const FILE_TYPE_MAP = {
  "image/png": "png",
  "image/jpeg": "jpeg",
  "image/jpg": "jpg",
};

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const isValid = FILE_TYPE_MAP[file.mimetype];
    let uploadError = new Error("invalid image type");

    if (isValid) {
      uploadError = null;
    }
    cb(uploadError, "public/uploads");
  },
  filename: function (req, file, cb) {
    const fileName = file.originalname.split(" ").join("-");
    const extension = FILE_TYPE_MAP[file.mimetype];
    cb(null, `${fileName}-${Date.now()}.${extension}`);
  },
});

const uploadOptions = multer({ storage: storage });

const {
  addProduct,
  getProducts,
  getProductById,
  featuredProducts,
  updateProduct,                   
  count,
  deleteProduct,
  multipleImages,
  addReview,
  filterByPrice,
  sorting,
  NewArrivalProducts,
} = require("../controllers/products_controller");

router.post("/add", uploadOptions.single("image"), cleanBody, addProduct);
router.patch("/addReview/:id", cleanBody, addReview);
router.get("/get", cleanBody, getProducts);
router.get("/newArrival", cleanBody, NewArrivalProducts);
router.get("/count", cleanBody, count);
router.get("/filterByPrice", cleanBody, filterByPrice);
router.patch(
  "/multipleImages/:id",
  uploadOptions.array("images", 10),
  multipleImages
);
router.get("/sorting", cleanBody, sorting);
router.get("/featured/", cleanBody, featuredProducts);
router.get("/:id", cleanBody, getProductById);
router.patch("/update/:id", cleanBody, updateProduct);
router.delete("/delete/:id", cleanBody, deleteProduct);

module.exports = router;
