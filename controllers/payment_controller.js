require("dotenv").config();
const stripe = require("stripe")(process.env.STRIPE_KEY);

exports.createCustomer = async (req, res) => {
  try {
    const token = await stripe.tokens.create({
      card: {
        number: req.body.card.number,
        exp_month: req.body.card.exp_month,
        exp_year: req.body.card.exp_year,
        cvc: req.body.card.cvc,
      },
    });
    const customer = await stripe.customers.create({
      name: req.body.name,
      description: "My Customer for SellCorner",
      source: token.id,
    });
    if (!customer) {
      return res.json({
        success: false,
        message: "Couldn't create customer",
      });
    } else {
      return res.json({
        customer: customer,
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

exports.getCustomerCard = async (req, res) => {
  try {
    const card = await stripe.customers.retrieveSource(
      req.params.id,
      req.params.card
    );

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
    const charge = await stripe.charges.create({
      amount: req.body.amount,
      description: "Order items from SellCorner",
      currency: req.body.currency,
      customer: req.body.customer,
      source: req.body.cardId,
      shipping: {
        name: req.body.name,
        address: {
          line1: req.body.address,
          postal_code: req.body.code,
          city: req.body.city,
          state: req.body.state,
          country: req.body.country,
        },
      },
    });
    if (!charge) {
      res.send({
        sucess: false,
        message: "Payemnt did not succeed",
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
