const mongoose = require('mongoose');

// Define the Wishlist schema
const wishlistSchema = new mongoose.Schema({
  userId: {
    type: Number, // Consider using String if you intend to use ObjectId later
    required: true,
  },
  wishlistedCourse: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Course', // Assuming you have a Course model
    required: true,
  }],
});

// Create the Wishlist model
const Wishlist = mongoose.model('Wishlist', wishlistSchema);

// Export the model
module.exports = Wishlist;
