const Product = require("../models/Product");
const Category = require("../models/Category");
var ObjectID = require("mongodb").ObjectID;
const mongoose = require("mongoose");
const cloudinary = require("cloudinary");
const socket = require("../app");

exports.searchProducts = async (req, res) => {
  try {
    const products = await Product.fuzzySearch(req.params.query).populate(
      "category"
    );

    if (!products) {
      return res.json("No products found");
    } else {
      return res.json({ results: products });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.addProduct = async (req, res) => {
  try {
    const {
      name,
      description,
      fullDescription,
      price,
      image,
      category,
      discount,
      onSale,
      subCategory,
      countInStock,
      isFeatured,
    } = req.body;

    const newCategory = await Category.findById(category);
    if (!newCategory) return res.status(400).send("Invalid Category");

    // Upload thumbnail to cloudinary
    const result = await cloudinary.uploader.upload(image);

    if (onSale === true && discount > 0) {
      const priceAfterDiscount = price - (price * req.body.discount) / 100;

      const product = new Product({
        name: name,
        description: description,
        fullDescription: fullDescription,
        thumbnail: result.secure_url,
        thumbnailId: result.public_id,
        price: price,
        discount: discount,
        onSale: onSale,
        totalPrice: priceAfterDiscount,
        category: category,
        subCategory: subCategory,
        countInStock: countInStock,
        isFeatured: isFeatured,
      });
      await product.save();
      res.json({
        success: true,
        product: product,
        message: "Product has been added",
      });
    } else {
      const product = new Product({
        name: name,
        description: description,
        fullDescription: fullDescription,
        thumbnail: result.secure_url,
        thumbnailId: result.public_id,
        price: price,
        totalPrice: price,
        onSale: onSale,
        category: category,
        subCategory: subCategory,
        countInStock: countInStock,
        isFeatured: isFeatured,
      });

      await product.save();

      res.json({
        success: true,
        product: product,
        message: "Product has been added",
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

exports.getProducts = async (req, res) => {
  try {
    const products = await Product.find({ status: true }).populate("category");
    res.json({ products });
  } catch (error) {
    res.status(500).json({ error: true, message: "Can't get products" });
  }
};

exports.getAdminProducts = async (req, res) => {
  try {
    var query = {};
    var options = {
      sort: { dateCreated: -1 },
      page: req.query.page ?? 1,
      limit: req.query.limit ?? 10,
      pagination: req.query.pagination === "true" ? true : false,
      populate: "category",
    };
    await Product.paginate(query, options, function (err, result) {
      if (err) {
        return res.status(500).json({ error: true, message: err.message });
      } else {
        return res.json({
          page: result.page,
          hasNextPage: result.hasNextPage,
          hasPrevPage: result.hasPrevPage,
          total_pages: result.totalPages,
          total_results: result.totalDocs,
          results: result.docs,
        });
      }
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

exports.getSimilarProducts = async (req, res) => {
  try {
    var query = {
      category: req.params.category,
      status: true,
      _id: { $ne: ObjectID(req.params.productId) },
    };
    var options = {
      sort: { dateCreated: -1 },
      page: req.query.page ?? 1,
      limit: req.query.limit ?? 10,
      populate: "category",
    };
    await Product.paginate(query, options, function (err, result) {
      if (err) {
        return res.status(500).json({ error: true, message: err.message });
      } else {
        return res.json({
          page: result.page,
          hasNextPage: result.hasNextPage,
          hasPrevPage: result.hasPrevPage,
          total_pages: result.totalPages,
          total_results: result.totalDocs,
          results: result.docs,
        });
      }
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
  var query = {
    status: true,
    dateCreated: { $gte: start },
  };
  var options = {
    sort: { dateCreated: -1 },
    page: req.query.page ?? 1,
    limit: req.query.limit ?? 10,
    populate: "category",
  };
  await Product.paginate(query, options, function (err, result) {
    if (err) {
      return res.status(500).json({ error: true, message: err.message });
    } else {
      return res.json({
        page: result.page,
        hasNextPage: result.hasNextPage,
        hasPrevPage: result.hasPrevPage,
        total_pages: result.totalPages,
        total_results: result.totalDocs,
        results: result.docs,
      });
    }
  });
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

exports.productsByCategory = async (req, res) => {
  try {
    // If query params is avaliable then get products by both category & subcategory
    if (req.query.subCategory) {
      var query = {
        category: req.params.categoryId,
        subCategory: req.query.subCategory,
      };
      var options = {
        sort: { dateCreated: -1 },
        page: req.query.page ?? 1,
        limit: req.query.limit ?? 10,
        populate: "category",
      };
      await Product.paginate(query, options, function (err, result) {
        if (err) {
          return res.status(500).json({ error: true, message: err.message });
        } else {
          return res.json({
            page: result.page,
            hasNextPage: result.hasNextPage,
            hasPrevPage: result.hasPrevPage,
            total_pages: result.totalPages,
            total_results: result.totalDocs,
            results: result.docs,
          });
        }
      });
    }
    // get by only category
    else {
      var query = {
        category: req.params.categoryId,
      };
      var options = {
        sort: { dateCreated: -1 },
        page: req.query.page ?? 1,
        limit: req.query.limit ?? 10,
        populate: "category",
      };
      await Product.paginate(query, options, function (err, result) {
        if (err) {
          return res.status(500).json({ error: true, message: err.message });
        } else {
          return res.json({
            page: result.page,
            hasNextPage: result.hasNextPage,
            hasPrevPage: result.hasPrevPage,
            total_pages: result.totalPages,
            total_results: result.totalDocs,
            results: result.docs,
          });
        }
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

exports.sortProducts = async (req, res) => {
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
  try {
    var query = {
      status: true,
      isFeatured: true,
    };
    var options = {
      sort: { dateCreated: -1 },
      page: req.query.page ?? 1,
      limit: req.query.limit ?? 10,
      populate: "category",
    };
    await Product.paginate(query, options, function (err, result) {
      if (err) {
        return res.status(500).json({ error: true, message: err.message });
      } else {
        return res.json({
          page: result.page,
          hasNextPage: result.hasNextPage,
          hasPrevPage: result.hasPrevPage,
          total_pages: result.totalPages,
          total_results: result.totalDocs,
          results: result.docs,
        });
      }
    });
  } catch (error) {
    res.status(500).json({ error: true, message: "Can't get products" });
  }
};

exports.updateProduct = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid product id");
    }

    const {
      name,
      description,
      fullDescription,
      price,
      image,
      category,
      discount,
      onSale,
      subCategory,
      countInStock,
      isFeatured,
    } = req.body;

    const newCategory = await Category.findById(req.body.category);
    if (!newCategory) return res.status(400).send("Invalid Category");

    // delete old thumbnail
    await cloudinary.uploader.destroy(req.body.thumbnailId);
    // upload new thumbnail again
    const result = await cloudinary.uploader.upload(image);

    // // delete old images
    await cloudinary.v2.api.delete_resources(
      req.body.imageIds,
      (error, result) => {
        console.log(result, error);
      }
    );

    let product;
    if (req.body.onSale === true && req.body.discount > 0) {
      const priceAfterDiscount =
        req.body.price - (req.body.price * req.body.discount) / 100;

      product = await Product.findByIdAndUpdate(
        req.params.id,
        {
          onSale: onSale,
          totalPrice: priceAfterDiscount,
          discount: discount,
        },
        { new: true }
      );
    } else {
      const newProduct = {
        name: name,
        description: description,
        fullDescription: fullDescription,
        thumbnail: result.secure_url,
        thumbnailId: result.public_id,
        price: price,
        totalPrice: price,
        onSale: onSale,
        category: category,
        subCategory: subCategory,
        countInStock: countInStock,
        isFeatured: isFeatured,
      };
      product = await Product.findByIdAndUpdate(
        req.params.id,
        { $set: newProduct },
        { new: true }
      );
    }

    if (!product) {
      return res.status(400).send("Product not found");
    }

    res.json({
      success: true,
      updatedProduct: product,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.updateFeatured = async (req, res) => {
  try {
    const product = await Product.findOneAndUpdate(
      req.params.id,
      {
        isFeatured: req.params.isFeatured,
      },
      { new: true }
    );
    socket.socket.emit("update-featured", product.isFeatured);
    res.json({
      success: true,
      message: "Featured has been updated",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.updateStatus = async (req, res) => {
  try {
    const product = await Product.findOneAndUpdate(
      req.params.id,
      {
        status: req.params.status,
      },
      { new: true }
    );
    socket.socket.emit("update-productStatus", product.status);
    res.json({
      success: true,
      message: "status has been updated",
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
  res.json({
    productCount: productCount,
  });
};

exports.deleteProduct = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid product id");
    }
    // delete thumbnail from cloudinary
    await cloudinary.uploader.destroy(req.body.thumbnailId);

    // delete images from cloudinary
    await cloudinary.v2.api.delete_resources(
      req.body.imageIds,
      (error, result) => {
        console.log(result, error);
      }
    );

    const product = await Product.findByIdAndRemove(req.params.id);

    const products = await Product.find();
    socket.socket.emit("delete-product", products);

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

  const uploader = async (path) => await cloudinary.uploader.upload(path);

  // Upload images to cloudinary
  const files = req.body.images;
  let product;
  for (const file of files) {
    const newPath = await uploader(file);
    product = await Product.findByIdAndUpdate(
      req.params.id,
      {
        $push: {
          images: {
            id: newPath.public_id,
            url: newPath.secure_url,
          },
        },
      },
      { new: true }
    );
  }

  if (!product) return res.status(500).send("Images cannot be upload!");

  res.json({
    success: true,
    message: "Images has been added",
  });
};
