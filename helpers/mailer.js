require("dotenv").config();
const sgMail = require("@sendgrid/mail");

async function sendEmail(email, code) {
  try {
    const senderAddress = "SellCorner <SellCorner1@gmail.com>";

    sgMail.setApiKey(process.env.SG_APIKEY);

    // Specify the fields in the email.
    let mailOptions = {
      from: senderAddress,
      to: email,
      templateId: "d-f0849983599447bd9afef90f6dc05afe",
      dynamic_template_data: {
        code: code,
      },
    };

    await sgMail.send(mailOptions);
    return { error: false };
  } catch (error) {
    console.error("send-email-error", error);
    return {
      error: true,
      message: "Cannot send email",
    };
  }
}

async function sendOrderEmail(email, orderId) {
  try {
    const senderAddress = "SellCorner <SellCorner1@gmail.com>";

    sgMail.setApiKey(process.env.SG_APIKEY);

    // Specify the fields in the email.
    let mailOptions = {
      from: senderAddress,
      to: email,
      templateId: " d-6a49bcf540e54ec7b243be13c3ffbe03",
      dynamic_template_data: {
        code: orderId,
      },
    };

    await sgMail.send(mailOptions);
    return { error: false };
  } catch (error) {
    console.error("send-email-error", error);
    return {
      error: true,
      message: "Cannot send email",
    };
  }
}

module.exports = { sendEmail };
