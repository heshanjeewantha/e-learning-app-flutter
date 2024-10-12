// Controllers/feedbackController.js
const Feedback = require("../model/Feedback");

// Get all feedbacks
const getAllFeedbacks = async (req, res) => {
  try {
    const feedbacks = await Feedback.find();
    res.status(200).json(feedbacks);
  } catch (error) {
    res.status(500).json({ message: "Error fetching feedbacks", error });
  }
};

// Create a new feedback
const createFeedback = async (req, res) => {
  console.log(req.body); // Log request body to debug
  const newFeedback = new Feedback(req.body); // Use req.body to get feedback data
  try {
    const savedFeedback = await newFeedback.save();
    res.status(201).json(savedFeedback);
  } catch (error) {
    res.status(500).json({ message: "Error creating feedback", error });
  }
};

module.exports = {
  getAllFeedbacks,
  createFeedback,
};
