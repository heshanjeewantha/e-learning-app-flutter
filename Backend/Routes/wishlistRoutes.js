const express = require("express");
const router = express.Router();
const Wishlist = require("../model/wishlistModel"); // Adjust the path if necessary

// Create a new wishlist
router.post("/", async (req, res) => {
  try {
    const newWishlist = new Wishlist(req.body);
    const savedWishlist = await newWishlist.save();
    res.status(201).json(savedWishlist);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get all wishlists
router.get("/", async (req, res) => {
  try {
    const wishlists = await Wishlist.find().populate("wishlistedCourse"); // Populate to get course details
    res.status(200).json(wishlists);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get a wishlist by user ID
router.get("/:userId", async (req, res) => {
  try {
    const wishlist = await Wishlist.findOne({
      userId: req.params.userId,
    }).populate("wishlistedCourse");
    if (!wishlist) {
      return res.status(404).json({ message: "Wishlist not found" });
    }
    res.status(200).json(wishlist);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update a wishlist
router.put("/:userId", async (req, res) => {
  try {
    const updatedWishlist = await Wishlist.findOneAndUpdate(
      { userId: req.params.userId },
      req.body,
      { new: true, runValidators: true } // Ensure validation rules are applied
    );
    if (!updatedWishlist) {
      return res.status(404).json({ message: "Wishlist not found" });
    }
    res.status(200).json(updatedWishlist);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Delete a wishlist
router.delete("/:userId", async (req, res) => {
  try {
    const deletedWishlist = await Wishlist.findOneAndDelete({
      userId: req.params.userId,
    });
    if (!deletedWishlist) {
      return res.status(404).json({ message: "Wishlist not found" });
    }
    res.status(204).send(); // No content to send back
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
