require("dotenv").config();
const nodemailer = require("nodemailer");
const { google } = require("googleapis");
const OAuth2 = google.auth.OAuth2;

async function sendEmail(email, code) {
  try {
    const oauth2Client = new OAuth2(
      process.env.CLIENT_ID, // ClientID
      process.env.CLIENT_SECRET, // Client Secret
      "https://developers.google.com/oauthplayground" // Redirect URL
 );

 oauth2Client.setCredentials({
  refresh_token: process.env.REFRESH_TOKEN,
});

const accessToken = oauth2Client.getAccessToken();

    var toAddress = email;

    var subject = "Verify your email";

    // The body of the email for recipients
    var body_html = `<!DOCTYPE> 
    <html>
      <body>
        <p>Your authentication code is : </p> <b>${code}</b>
      </body>
    </html>`;

    // Create the SMTP transport.
    let transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        type: "OAuth2",
        // replace it with your details
        user: process.env.SENDER_EMAIL, 
        clientId: process.env.CLIENT_ID,
        clientSecret: process.env.CLIENT_SECRET,
        refreshToken: process.env.REFRESH_TOKEN,
        accessToken: accessToken
      },
    });

    // Specify the fields in the email.
    let mailOptions = {
      from: `Stylish <${process.env.SENDER_EMAIL}>`,
      to: toAddress,
      subject: subject,
      html: body_html,
    };

    let info = await transporter.sendMail(mailOptions);
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
