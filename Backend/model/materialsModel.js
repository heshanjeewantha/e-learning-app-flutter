const mongoose = require('mongoose');

const materialsSchema = new mongoose.Schema({
  id: {
    type: Number, // Consider using String for MongoDB IDs
    required: true,
    unique: true,
  },
  section: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'sectionModel', // Reference to the Section model
    // Ensure every material is linked to a section
  },
  material_type: {
    type: String,
    required: true,
  },
  material_name: {
    type: String,
    required: true,
  },
  material_url: {
    type: String,
    required: true,
  },
  is_completed: {
    type: Boolean,
    default: false,
  },
});

const Materials = mongoose.model('Materials', materialsSchema);
module.exports = Materials;
