const mongoose = require("mongoose");
const cloudinary = require("cloudinary");
const socket = require("..");
const Banner = require("../models/Banner");
const Product = require("../models/Product");

exports.addBanner = async (req, res) => {
  try {
    const { image, type } = req.body;

    if (!image || !type) {
      return res.json({
        success: false,
        message: "All fields are required",
      });
    }

    // Upload image to cloudinary
    const result = await cloudinary.uploader.upload(image);
    if (type === "General") {
      const banner = new Banner({
        image: result.secure_url,
        imageId: result.public_id,
        type: type,
      });
      await banner.save();
      const banners = await Banner.find();
      socket.socket.emit("add-banner", banners);
      res.json({
        success: true,
        message: "Banner has been added",
      });
    } else {
      const banner = new Banner({
        image: result.secure_url,
        imageId: result.public_id,
        type: type,
        products: req.body.products,
      });
      await banner.save();

      const banners = await Banner.find();
      socket.socket.emit("add-banner", banners);

      res.json({
        success: true,
        banners: banners,
        message: "Banner has been added",
      });
    }
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.getUserBanners = async (req, res) => {
  try {
    const banners = await Banner.find({ status: true });
    res.status(200).json({
      success: true,
      banners: banners,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};
exports.getAdminBanners = async (req, res) => {
  try {
    const banners = await Banner.find();
    res.status(200).json({
      success: true,
      banners: banners,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.updateStatus = async (req, res) => {
  try {
    const banner = await Banner.findByIdAndUpdate(
      req.params.id,
      {
        status: req.params.status,
      },
      { new: true }
    );
    socket.socket.emit("update-bannerStatus", banner.status);
    res.json({
      success: true,
      message: "Status has been updated",
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.updateBanner = async (req, res) => {
  try {
    // delete image
    await cloudinary.uploader.destroy(req.body.imageId);
    // upload new again
    const result = await cloudinary.uploader.upload(req.body.image);

    const banner = await Banner.findByIdAndUpdate(
      req.params.id,
      {
        $set: {
          image: result.secure_url,
          imageId: result.public_id,
        },
      },
      { new: true }
    );
    const banners = await Banner.find();
    socket.socket.emit("edit-banner", banners);
    if (!banner) return res.status(400).send("banner not found");

    res.json({
      success: true,
      message: "Banner has been updated",
    });
  } catch (error) {
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.addBannerProducts = async (req, res) => {
  try {
    const { product, products } = req.body;
    // Add product
    await Banner.findOneAndUpdate(
      { _id: req.params.id },
      {
        products: products,
      },
      { new: true }
    );

    // Update discount
    product.map(async (item) => {
      const priceAfterDiscount =
        item.price - (item.price * item.discount) / 100;

      await Banner.findOneAndUpdate(
        {
          _id: req.params.id,
          "products._id": item.id,
        },
        {
          $set: {
            "products.$.onSale": true,
            "products.$.discount": item.discount,
            "products.$.totalPrice": priceAfterDiscount,
          },
        }
      );
    });

    const banners = await Banner.find();
    socket.socket.emit("add-bannerProducts", banners);

    res.json({
      success: true,
      message: "Banner has been updated",
    });
  } catch (error) {
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.removeBannerProduct = async (req, res) => {
  try {
    // Update products discount and price

    await Product.findOneAndUpdate(
      { _id: req.body.productId },
      {
        $set: {
          onSale: false,
          discount: 0,
          totalPrice: req.body.productPrice,
        },
      },
      { multi: true }
    );

    await Banner.findByIdAndUpdate(req.params.id, {
      $pull: {
        products: {
          _id: req.body.productId,
        },
      },
    });

    const banners = await Banner.find();
    socket.socket.emit("remove-bannerProduct", banners);

    res.json({
      success: true,
      message: "Banner has been removed",
    });
  } catch (error) {
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.deleteBanner = async (req, res) => {
  try {
    // delete image
    await cloudinary.uploader.destroy(req.body.imageId);

    await Banner.findByIdAndDelete(req.params.id);

    const banners = await Banner.find();
    socket.socket.emit("delete-banner", banners);

    res.status(200).json({
      success: true,
      message: "Banner has been deleted",
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};
