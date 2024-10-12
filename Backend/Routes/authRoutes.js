const express = require("express");
const jwt = require("jsonwebtoken");
const User = require("../model/userModel");
const router = express.Router();
const bcrypt = require("bcrypt");

// Login a user
router.post("/login", async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Remove password comparison logic
    // const isMatch = await user.comparePassword(password);
    // if (!isMatch) {
    //   return res.status(401).json({ message: 'Invalid credentials' });
    // }

    // Create a JWT token
    const token = jwt.sign(
      { jti: user._id, sub: user.email },
      "your_jwt_secret",
      { expiresIn: "1h" }
    );

    // Remove the password field from the user object before returning
    const userData = user.toObject();
    delete userData.password;

    res.status(200).json({ token, user: userData });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
