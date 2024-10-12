// models/Feedback.js
const mongoose = require("mongoose");

const FeedbackSchema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    username: { type: String, required: true },
    time: { type: String, required: true },
    product: { type: String, required: true },
    comment: { type: String, required: true },
    imageSrc: { type: String },
  },
  { timestamps: true }
);

const Feedback = mongoose.model("Feedback", FeedbackSchema);

module.exports = Feedback;
