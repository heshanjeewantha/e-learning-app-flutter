const mongoose = require('mongoose');

const reviewSchema = new mongoose.Schema({
  id: {
    type: String, // Consider using String for MongoDB IDs
    required: true,
    unique: true,
  },
  rating: {
    type: Number,
    min: 0,
    max: 5,
    required: true, // Ensure rating is provided
  },
  review: {
    type: String,
    required: true, // Ensure review content is provided
  },
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User', // Reference to the User model
    
  },
  course: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Course', // Reference to the Course model
    // Ensure every review is linked to a course
  },
});

const Review = mongoose.model('Review', reviewSchema);
module.exports = Review;
