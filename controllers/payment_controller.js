require("dotenv").config();
const stripe = require("stripe")(process.env.STRIPE_KEY);

exports.addCard = async (req, res) => {
  try {
    const paymentMethod = await stripe.paymentMethods.create({
      type: "card",
      card: {
        number: req.body.card.number,
        exp_month: req.body.card.exp_month,
        exp_year: req.body.card.exp_year,
        cvc: req.body.card.cvc,
      },
    });
    await stripe.paymentMethods.attach(paymentMethod.id, {
      customer: req.body.customerId,
    });

    if (!paymentMethod) {
      return res.json({
        success: false,
        message: "Couldn't add paymentMethod",
      });
    } else {
      return res.json({
        card: paymentMethod,
      });
    }
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.deleteCard = async (req, res) => {
  try {
    const card = await stripe.paymentMethods.detach(req.params.id);

    if (!card) {
      return res.json({
        success: false,
        message: "Couldn't delete card",
      });
    } else {
      return res.json("Card deleted");
    }
  } catch (error) {
    console.log(error.raw.message);
    return res.json({
      success: false,
      message: error.raw.message,
    });
  }
};

exports.getCustomerCards = async (req, res) => {
  try {
    const card = await stripe.paymentMethods.list({
      customer: req.params.id,
      type: "card",
    });

    if (!card) {
      return res.json({
        success: false,
        message: "Couldn't get card",
      });
    } else {
      return res.json({
        card: card,
      });
    }
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.payAmount = async (req, res) => {
  try {
    const charge = await stripe.paymentIntents.create({
      amount: req.body.amount,
      currency: "pkr",
      description: "Order payment for SellCorner",
      customer: req.body.customer,
      payment_method: req.body.card,
      payment_method_types: ["card"],
      shipping: {
        name: req.body.customerName,
        address: {
          line1: req.body.address,
          city: req.body.city,
          country: req.body.country,
        },
      },
    });
    const confirmpayment = await stripe.paymentIntents.confirm(charge.id, {
      payment_method: req.body.card,
      shipping: {
        name: req.body.customerName,
        address: {
          line1: req.body.address,
          city: req.body.city,
          country: req.body.country,
        },
      },
    });
    if (!confirmpayment) {
      res.send({
        sucess: false,
        message: "Payment did not succeed",
      });
    } else {
      res.send("Payment successful");
    }
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};
