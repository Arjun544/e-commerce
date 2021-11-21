const Order = require("../models/Order");
const socket = require("../app");

exports.addOrder = async (req, res) => {
  try {
    const totalPrices = await Promise.all(
      req.body.orderItems.map(async (item) => {
        if (item.onSale === true && item.discount > 0) {
          const totalPrice = item.totalPrice * item.quantity;
          return totalPrice;
        } else {
          const totalPrice = item.price * item.quantity;
          return totalPrice;
        }
      })
    );
    const totalPrice =
      totalPrices.reduce((a, b) => a + b, 0) + req.body.deliveryFee;

    let order = new Order({
      orderItems: req.body.orderItems,
      shippingAddress: req.body.shippingAddress,
      payment: req.body.payment,
      deliveryType: req.body.deliveryType,
      deliveryFee: req.body.deliveryFee,
      city: req.body.city,
      country: req.body.country,
      phone: req.body.phone,
      status: req.body.status,
      totalPrice: totalPrice,
      user: req.body.user,
    });
    order = await order.save();

    res.json({
      success: true,
      // orders: order,
    });
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.getOrders = async (req, res) => {
  try {
    const orderList = await Order.find().sort({ dateOrdered: -1 });

    res.send({
      success: true,
      orderList: orderList,
    });
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.getOrderById = async (req, res) => {
  try {
    const order = await Order.findById(req.params.id);

    res.send({
      success: true,
      orderList: order,
    });
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.updateStatus = async (req, res) => {
  try {
    let newOrder;
    if (req.body.status !== "") {
      newOrder = await Order.findByIdAndUpdate(
        req.params.id,
        {
          status: req.body.status,
        },
        { new: true }
      );
    } else {
      newOrder = await Order.findByIdAndUpdate(
        req.params.id,
        {
          isPaid: req.body.paidStatus,
        },
        { new: true }
      );
    }

    if (!newOrder) return res.status(400).send("the order cannot be update!");

    if (req.body.isSettingOrders === true) {
      const orderList = await Order.find().sort({ dateOrdered: -1 });
      socket.socket.emit("update-orderStatus", orderList);
    } else if (req.body.isSettingOrders === false) {
      socket.socket.emit("update-orderStatus", newOrder);
    }

    res.send({
      success: true,
      message: "Status has been updated",
    });
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.deleteOrder = async (req, res) => {
  try {
    const order = await Order.findByIdAndRemove(req.params.id);
    if (!order) {
      return res
        .status(200)
        .json({ success: true, message: "Order not found!" });
    } else {
      return res
        .status(200)
        .json({ success: true, message: "Order is deleted!" });
    }
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.totalSales = async (req, res) => {
  const totalSales = await Order.aggregate([
    { $group: { _id: null, totalsales: { $sum: "$totalPrice" } } },
  ]);

  if (!totalSales) {
    return res.status(400).send("The order sales cannot be generated");
  }

  res.send({ totalsales: totalSales.pop().totalsales });
};

exports.count = async (req, res) => {
  const orderCount = await Order.countDocuments((count) => count);

  if (!orderCount) {
    res.status(500).json({ success: false });
  }
  res.send({
    orderCount: orderCount,
  });
};

exports.userOrders = async (req, res) => {
  try {
    const userOrderList = await Order.find({ "user.id": req.params.id }).sort({
      dateOrdered: -1,
    });

    if (!userOrderList) return res.status(400).send("No Orders");

    res.send({
      success: true,
      orderList: userOrderList,
    });
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};
