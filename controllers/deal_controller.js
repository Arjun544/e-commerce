const socket = require("../app");
const Deal = require("../models/Deal");
const Product = require("../models/Product");

exports.addDeal = async (req, res) => {
  try {
    const { title, startDate, endDate } = req.body;

    const deal = new Deal({
      title,
      startDate,
      endDate,
    });
    await deal.save();
    const deals = await Deal.find();
    socket.socket.emit("add-deal", deals);
    res.send({
      success: true,
      message: "Deal has been added",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.getAdminDeals = async (req, res) => {
  try {
    const deals = await Deal.find();
    res.send({
      success: true,
      deals: deals,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.updateDeal = async (req, res) => {
  try {
    const { title, startDate, endDate } = req.body;

    const deal = await Deal.findByIdAndUpdate(
      req.params.id,
      {
        $set: {
          title: title,
          startDate: startDate,
          endDate: endDate,
        },
      },
      { new: true }
    );
    const deals = await Deal.find();
    socket.socket.emit("edit-deal", deals);
    if (!deal) return res.status(400).send("deal not found");

    res.json({
      success: true,
      message: "Deal has been updated",
    });
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.addDealProducts = async (req, res) => {
  try {
    // Update products discount and price
    req.body.product.map(async (item) => {
      const priceAfterDiscount =
        item.price - (item.price * item.discount) / 100;

      await Product.updateMany(
        { _id: { $in: item.id } },
        {
          $set: {
            onSale: true,
            discount: item.discount,
            totalPrice: priceAfterDiscount,
          },
        },
        { multi: true }
      );
    });

    await Deal.findOneAndUpdate(
      { _id: req.params.id },
      {
        products: req.body.products,
      },
      { new: true }
    );

    const deals = await Deal.find();
    socket.socket.emit("add-dealProducts", deals);

    res.json({
      success: true,
      message: "Deal has been updated",
    });
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.deleteDeal = async (req, res) => {
  try {
    await Deal.findByIdAndDelete(req.params.id);

    const deals = await Deal.find();
    socket.socket.emit("delete-deal", deals);

    res.status(200).json({
      success: true,
      message: "Deal has been deleted",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};
