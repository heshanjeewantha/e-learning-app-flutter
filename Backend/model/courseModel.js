const mongoose = require('mongoose');

const courseSchema = new mongoose.Schema({
  id: { type: Number, unique: true },
  courseName: { type: String },
  description: { type: String },
  totalVideo: { type: Number },
  totalTime: { type: String }
});

module.exports = mongoose.model('Course', courseSchema);
