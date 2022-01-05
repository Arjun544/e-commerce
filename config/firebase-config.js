var admin = require("firebase-admin");

var serviceAccount = require("../sellcorner-d036f-firebase-adminsdk-z3ia2-0cbb01739c.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "",
});

module.exports.admin = admin;
