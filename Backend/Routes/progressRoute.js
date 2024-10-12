const express = require("express");
const router = express.Router();
const Progress = require("../model/progressModel");

// Add new progress
router.post("/add", async (req, res) => {
  try {
    const { courseName, progressPercentage, studentId } = req.body;

    // Validate progress percentage
    if (progressPercentage < 0 || progressPercentage > 100) {
      return res
        .status(400)
        .json({ error: "Progress percentage must be between 0 and 100" });
    }

    // Create a new progress entry
    const newProgress = new Progress({
      courseName,
      progressPercentage,
      studentId,
      lastUpdated: Date.now(),
    });

    await newProgress.save();
    res.status(201).json(newProgress);
  } catch (err) {
    res.status(500).json({ error: "Server error" });
  }
});

// Update existing progress
router.post("/update", async (req, res) => {
  try {
    const { courseName, studentId, progressPercentage } = req.body;

    // Validate progress percentage
    if (progressPercentage < 0 || progressPercentage > 100) {
      return res
        .status(400)
        .json({ error: "Progress percentage must be between 0 and 100" });
    }

    // Find progress entry or create a new one
    const progress = await Progress.findOneAndUpdate(
      { courseName, studentId },
      { progressPercentage, lastUpdated: Date.now() },
      { new: true, upsert: true } // upsert will create new if not found
    );
    res.json(progress);
  } catch (err) {
    res.status(500).json({ error: "Server error" });
  }
});

// Get progress for a specific student
router.get("/:studentId", async (req, res) => {
  try {
    const { studentId } = req.params;
    const progressData = await Progress.find({ studentId });
    if (progressData.length === 0) {
      return res
        .status(404)
        .json({ message: "No progress data found for this student" });
    }
    res.json(progressData);
  } catch (err) {
    res.status(500).json({ error: "Server error" });
  }
});

// Get all progress data
router.get("/", async (req, res) => {
  try {
    const allProgressData = await Progress.find();
    res.json(allProgressData);
  } catch (err) {
    res.status(500).json({ error: "Server error" });
  }
});

module.exports = router;
