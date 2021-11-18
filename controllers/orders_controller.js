const Order = require("../models/Order");

exports.addOrder = async (req, res) => {
  try {
    const totalPrices = await Promise.all(
      req.body.orderItems.map(async (item) => {
        if (item.product.onSale === true && item.product.discount > 0) {
          const totalPrice = item.product.totalPrice * item.product.quantity;
          return totalPrice;
        } else {
          const totalPrice = item.product.price * item.product.quantity;
          return totalPrice;
        }
      })
    );

    const totalPrice =
      totalPrices.reduce((a, b) => a + b, 0) + req.body.deliveryFee;
    console.log(totalPrice);

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
      orders: order,
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
      sucess: true,
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
    const order = await Order.findById(req.params.id).populate("user");

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
    const order = await Order.findByIdAndUpdate(
      req.params.id,
      {
        status: req.body.status,
      },
      { new: true }
    );

    if (!order) return res.status(400).send("the order cannot be update!");

    res.send({
      success: true,
      order: order,
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
      orders: userOrderList,
    });
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};
