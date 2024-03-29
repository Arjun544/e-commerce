const Cart = require("../models/Cart");
const CartItem = require("../models/CartItem");
const mongoose = require("mongoose");
const socket = require("..");
var ObjectID = require("mongodb").ObjectID;

exports.addToCart = async (req, res) => {
  try {
    const userCart = await Cart.findOne({ user: req.body.user });

    const ids = userCart.products.map((item) => item.id);
    if (ids.includes(req.body.product.id)) {
      await Cart.findOneAndUpdate(
        {
          user: req.body.user,
          "products.id": req.body.product.id,
        },
        {
          $inc: { "products.$.quantity": 1 },
          new: true,
        }
      );
    } else {
      await Cart.findOneAndUpdate(
        { user: req.body.user },
        {
          $push: {
            products: req.body.product,
          },
          new: true,
        }
      );
    }

    socket.socket.emit("cartCount", userCart.products.length);

    res.json({
      success: true,
      message: "Added to cart",
    });
  } catch (error) {
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.getCart = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid cart id");
    }

    const cartList = await Cart.find({ user: req.params.id }).sort({
      dateOrdered: -1,
    });

    res.json(cartList[0]);
  } catch (error) {
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.updateQuantity = async (req, res) => {
  try {
    if (!req.body.productId) {
      res.json({
        error: true,
        message: "Please provide all fields",
      });
    }

    const newProduct = await Cart.findOneAndUpdate(
      {
        user: req.params.id,
        "products.id": req.body.productId,
      },
      {
        $set: { "products.$.quantity": req.body.value },
      },
      { new: true }
    );

    const updatedProduct = newProduct.products.filter(
      (item) => item.id === req.body.productId
    );

    const prices = newProduct.products.map(
      (item) => item.totalPrice * item.quantity
    );
    const totalFinal = prices.reduce((partial_sum, a) => partial_sum + a, 0);

    const eventEmitter = req.app.get("eventEmitter");
    socket.socket.emit("updatedCart", {
      id: updatedProduct[0]._id,
      quantity: updatedProduct[0].quantity,
      totalGrand: totalFinal,
    });

    return res.json({
      message: "Quantity has been updated",
    });
  } catch (error) {
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.deleteFromCart = async (req, res) => {
  try {
    const product = await Cart.findByIdAndUpdate(req.params.id, {
      $pull: {
        products: {
          id: req.body.productId,
        },
      },
    });
    if (!product) {
      return res.json("No product found");
    }

    return res.status(200).json({
      success: false,
      message: "Cart item has been deleted",
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.cartCount = async (req, res) => {
  try {
    const userCart = await Cart.findOne({ user: ObjectID(req.params.id) });

    res.status(200).json(userCart.products.length);
  } catch (error) {
    res.status(500).json({ error: true, message: "Something went wrong" });
  }
};

exports.clearCart = async (req, res) => {
  try {
    const cart = await Cart.findOneAndUpdate(
      { user: req.params.id },
      {
        $set: {
          products: [],
        },
      }
    );

    if (!cart) {
      res.json({
        error: true,
        message: "Cart not found for user",
      });
    } else {
      return res.json("Cart cleared");
    }
  } catch (error) {
    return res.status(500).json({ error: true, message: error });
  }
};
