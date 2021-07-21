const Cart = require("../models/Cart");
const CartItem = require("../models/CartItem");
const mongoose = require("mongoose");

exports.addToCart = async (req, res) => {
  try {
    const cartItemsIds = Promise.all(
      req.body.cartItems.map(async (cartItem) => {
        let newCartItem = new CartItem({
          product: cartItem.product,
          userId: req.body.user,
        });

        newCartItem = await newCartItem.save();

        return newCartItem._id;
      })
    ).catch(function (error) {
      if (error.name == "ValidationError") {
        return res.json({
          error: true,
          message: error.errors.quantity.message,
        });
      }
    });

    const cartItemsIdsResolved = await cartItemsIds;

    let cart = new Cart({
      cartItems: cartItemsIdsResolved,
      user: req.body.user,
    });
    cart = await cart.save();

    res.json({
      success: true,
      cart: cart,
    });
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.getCart = async (req, res) => {
  try {
    if (!mongoose.isValidObjectId(req.params.id)) {
      return res.status(400).send("Invalid user id");
    }

    const cartList = await Cart.find({ user: req.params.id })
      .populate("cartItems")
      .populate({
        path: "cartItems",
        populate: {
          path: "product",
          model: "Product",
        },
      })
      .sort({ dateOrdered: -1 });

    // Calculating total grand of cart items
    const totalPrices = await Promise.all(
      cartList.map(async (item) => {
        const newCartItem = await CartItem.findById(
          item.cartItems[0]._id
        ).populate("product");
        let totalPrice;
        if (newCartItem.product.onSale === false) {
          totalPrice = newCartItem.product.price * newCartItem.quantity;
          return totalPrice;
        } else {
          totalPrice = newCartItem.product.totalPrice * newCartItem.quantity;
          return totalPrice;
        }
      })
    );

    const totalGrand = totalPrices.reduce((a, b) => a + b, 0);

    res.send({
      totalGrand: totalGrand,
      cartList: cartList,
    });
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.incrementQuantity = async (req, res) => {
  try {
    const cartItem = await CartItem.findByIdAndUpdate(
      { _id: req.params.id },
      {
        $inc: { quantity: 1 },
      },
      { new: true }
    )
      .populate("product")
      .select("quantity")
      .sort({ dateOrdered: -1 });

    if (!cartItem) {
      res.send({
        error: true,
        message: "Product not found in cart",
      });
    } else {
      // emit event for upating new quantity
      const eventEmitter = req.app.get("eventEmitter");
      eventEmitter.emit("updatedQuantity", {
        id: req.params.id,
        quantity: cartItem.quantity,
      });

      res.send("Quantity has been incremented");
    }
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.decrementQuantity = async (req, res) => {
  try {
    const cartItem = await CartItem.findByIdAndUpdate(
      { _id: req.params.id },
      {
        $inc: { quantity: -1 },
      },
      { new: true }
    )
      .populate("product")
      .select("quantity")
      .sort({ dateOrdered: -1 });

    if (!cartItem) {
      res.send({
        error: true,
        message: "Product not found in cart",
      });
    } else {
      // emit event for upating new quantity
      const eventEmitter = req.app.get("eventEmitter");
      eventEmitter.emit("updatedQuantity", {
        id: req.params.id,
        quantity: cartItem.quantity,
      });

      res.send("Quantity has been decremented");
    }
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.deleteFromCart = (req, res) => {
  Cart.findByIdAndRemove(req.params.id)
    .then(async (item) => {
      if (item) {
        await item.cartItems.map(async (cartItem) => {
          await CartItem.findByIdAndRemove(cartItem);
        });
        return res.json("Product is removed");
      } else {
        return res
          .status(404)
          .json({ error: true, message: "Product not found!" });
      }
    })
    .catch((err) => {
      return res.status(500).json({ error: true, message: err });
    });
};

exports.clearCart = async (req, res) => {
  try {
    const cart = await Cart.deleteMany({
      user: req.params.userId,
    });
    const cartItems = await CartItem.deleteMany({
      userId: req.params.userId,
    });
    if (!cart && !cartItems) {
      res.send({
        error: true,
        message: "Cart not found for user",
      });
    } else {
      res.send("Cart cleared");
    }
  } catch (error) {
    return res.status(500).json({ error: true, message: error });
  }
};
