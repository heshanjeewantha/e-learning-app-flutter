// routes/feedbackRoutes.js
const express = require("express");
const router = express.Router();
const feedbackController = require("../Controllers/feedbackController");

// Routes for feedback
router.get("/", feedbackController.getAllFeedbacks);
router.post("/", feedbackController.createFeedback);

module.exports = router;
