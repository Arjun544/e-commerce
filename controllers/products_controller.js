const Product = require("../models/Product");
const Category = require("../models/Category");
const User = require("../models/User");
const mongoose = require("mongoose");

exports.addProduct = async (req, res) => {
  try {
    const {
      name,
      description,
      fullDescription,
      price,
      category,
      countInStock,
      totalReviews,
      isFeatured,
    } = req.body;

    if (
      !name ||
      !description ||
      !fullDescription ||
      !price ||
      !category ||
      !countInStock ||
      !totalReviews ||
      !isFeatured
    ) {
      return res.status(500).json({
        success: false,
        message: "All fields are required",
      });
    }

    const newCategory = await Category.findById(req.body.category);
    if (!newCategory) return res.status(400).send("Invalid Category");

    const file = req.file;
    if (!file) return res.status(400).send("No image in the request");

    const fileName = file.filename;
    const basePath = `${req.protocol}://${req.get("host")}/public/uploads/`;
    let product = new Product({
      name: req.body.name,
      description: req.body.description,
      fullDescription: req.body.fullDescription,
      image: `${basePath}${fileName}`, // "http://localhost:3000/public/upload/image-2323232"
      price: req.body.price,
      category: req.body.category,
      countInStock: req.body.countInStock,
      totalReviews: req.body.totalReviews,
      isFeatured: req.body.isFeatured,
    });

    product = await product.save();

    res.send(product);
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.getProducts = async (req, res) => {
  try {
    // Get products by category if query is provided, otherwise get all products
    let filter = {};
    if (req.query.categories) {
      if (!mongoose.isValidObjectId(req.query.categories)) {
        return res.status(400).send("Invalid product id");
      }
      filter = { category: req.query.categories.split(",") };
    }

    const productsList = await Product.find(filter).populate("category");
    res.status(200).json({
      success: true,
      products: productsList,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.getProductById = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid product id");
    }

    const product = await Product.findById(req.params.id).populate("category");

    res.status(200).json({
      success: true,
      products: product,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.NewArrivalProducts = async (req, res) => {
  // Getting new arrivals in last 2 days
  var start = new Date(new Date().getTime() - 48 * 60 * 60 * 1000);

  const products = await Product.find({ dateCreated: { $gte: start } });

  if (!products) {
    res.status(500).json({ success: false });
  }
  res.send(products);
};

exports.filterByPrice = async (req, res) => {
  try {
    const productsList = await Product.find({
      price: { $gte: req.query.min, $lte: req.query.max },
    }).populate("category");
    res.status(200).json({
      success: true,
      products: productsList,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.sorting = async (req, res) => {
  try {
    let productsList;
    // Get newest products
    if (req.query.sortBy === "newest") {
      productsList = await Product.find()
        .sort({ dateCreated: -1 })
        .populate("category");
    }

    // Get oldest products
    if (req.query.sortBy === "oldest") {
      productsList = await Product.find()
        .sort({ dateCreated: 1 })
        .populate("category");
    }

    //Get Low to High Pricing
    if (req.query.sortBy === "Low to High Pricing") {
      productsList = await Product.find()
        .sort({ price: 1 })
        .populate("category");
    }

    //Get High to Low Pricing
    if (req.query.sortBy === "High to Low Pricing") {
      productsList = await Product.find()
        .sort({ price: -1 })
        .populate("category");
    }

    res.status(200).json({
      success: true,
      products: productsList,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.featuredProducts = async (req, res) => {
  const products = await Product.find({ isFeatured: true });

  if (!products) {
    res.status(500).json({ success: false });
  }
  res.send({ products: products });
};

exports.updateProduct = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid product id");
    }
    const newCategory = await Category.findById(req.body.category);
    if (!newCategory) return res.status(400).send("Invalid Category");

    let product;
    if (req.body.onSale === "true") {
      const item = await Product.findById(req.params.id).select("price");
      console.log(item.price);
      if (req.body.discount >= item.price) {
        return res.status(400).send("Discount can't be larger than price");
      }

      const totalPrice = parseInt(item.price) - parseInt(req.body.discount);

      product = await Product.findByIdAndUpdate(
        req.params.id,
        {
          onSale: req.body.onSale,
          totalPrice: totalPrice,
          discount: req.body.discount,
        },
        { new: true }
      );
      if (!product) {
        return res.status(400).send("Product not found");
      }

      res.send({
        success: true,
        updatedProduct: product,
      });
    } else {
      product = await Product.findByIdAndUpdate(
        req.params.id,
        { $set: req.body },
        { new: true }
      );
      if (!product) {
        return res.status(400).send("Product not found");
      }

      res.send({
        success: true,
        updatedProduct: product,
      });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.addReview = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid product id");
    }

    const { userId, review } = req.body;
    if (!userId) {
      res.json("All fields arer required");
    } else if (review.length < 3) {
      res.json("Review length can't be less than 3");
    }

    const userById = await User.findById(userId).select("username");

    await Product.findByIdAndUpdate(
      req.params.id,
      {
        $inc: { totalReviews: 1 },
        $push: {
          reviews: { user: userById, review: review, addedAt: Date.now() },
        },
      },

      { new: true }
    );

    res.send({
      success: true,
      message: "Review has been added",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.count = async (req, res) => {
  const productCount = await Product.countDocuments((count) => count);

  if (!productCount) {
    res.status(500).json({ success: false });
  }
  res.send({
    productCount: productCount,
  });
};

exports.deleteProduct = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid product id");
    }

    const product = await Product.findByIdAndRemove(req.params.id);

    if (!product) {
      res.status(403).send({ success: false, msg: "product not found" });
    } else {
      return res.status(200).json({
        success: true,
        message: "Deleted product",
      });
    }
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.multipleImages = async (req, res) => {
  if (!mongoose.isValidObjectId(req.params.id)) {
    return res.status(400).send("Invalid Product Id");
  }
  const files = req.files;
  let imagesPaths = [];
  const basePath = `${req.protocol}://${req.get("host")}/public/uploads/`;

  if (files) {
    files.map((file) => {
      imagesPaths.push(`${basePath}${file.filename}`);
    });
  }

  const product = await Product.findByIdAndUpdate(
    req.params.id,
    {
      images: imagesPaths,
    },
    { new: true }
  );

  if (!product) return res.status(500).send("the gallery cannot be updated!");

  res.send(product);
};
