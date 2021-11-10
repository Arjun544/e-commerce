const jwt = require("jsonwebtoken");
const accessTokenSecret = process.env.ACCESS_JWT_SECRET;
const refreshTokenSecret = process.env.REFRESH_JWT_SECRET;
const Token = require("../models/Token");
class TokenService {
  generateTokens(payload) {
    const accessToken = jwt.sign(payload, accessTokenSecret);
    const refreshToken = jwt.sign(payload, refreshTokenSecret, {
      expiresIn: "1y",
    });
    return { accessToken, refreshToken };
  }

  async verifyAccessToken(token) {
    return jwt.verify(token, accessTokenSecret);
  }

  async verifyRefreshToken(refreshToken) {
    return jwt.verify(refreshToken, refreshTokenSecret);
  }

  async findRefreshToken(userId, refreshToken) {
    return await Token.findOne({
      userId: userId,
      token: refreshToken,
    });
  }

  async updateRefreshToken(userId, refreshToken) {
    return await Token.updateOne({ userId: userId }, { token: refreshToken });
  }

  async removeToken(acessToken) {
    return await Token.deleteOne({ token: acessToken });
  }
}

module.exports = new TokenService();
