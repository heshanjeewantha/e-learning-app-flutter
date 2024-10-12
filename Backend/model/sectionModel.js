const mongoose = require('mongoose');

const sectionSchema = new mongoose.Schema({
  id: {
    type: Number, // Consider using String for MongoDB IDs
    required: true,
    unique: true,
  },
  course: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'courseModel', // Reference to the Course model
    required: true, // Ensure every section is linked to a course
  },
  section_name: {
    type: String,
    required: true,
  },
  materials: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'materialsModel', // Reference to your Materials model
  }],
});

const Section = mongoose.model('Section', sectionSchema);
module.exports = Section;
