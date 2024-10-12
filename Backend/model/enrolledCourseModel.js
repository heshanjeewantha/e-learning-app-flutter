const mongoose = require('mongoose');

const enrolledCourseSchema = new mongoose.Schema({
  id: {
    type: Number, // Consider using String for MongoDB IDs
    required: true,
    unique: true,
  },
  rating: {
    type: Number,
    min: 0,
    max: 5,
  },
  progress: {
    type: Number,
    min: 0,
    max: 100,
  },
  review: {
    type: String,
  },
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User', // Reference to the User model
    required: true, // Ensure every enrolled course is linked to a user
  },
  course: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Course', // Reference to the Course model
    required: true, // Ensure every enrolled course is linked to a course
  },
  
});

const EnrolledCourse = mongoose.model('EnrolledCourse', enrolledCourseSchema);
module.exports = EnrolledCourse;
