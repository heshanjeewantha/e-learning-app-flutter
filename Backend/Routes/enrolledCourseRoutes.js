const express = require("express");
const router = express.Router();
const EnrolledCourse = require("../model/enrolledCourseModel"); // Adjust the path as necessary

// Create a new enrolled course
router.post("/", async (req, res) => {
  try {
    const newEnrolledCourse = new EnrolledCourse(req.body);
    const savedEnrolledCourse = await newEnrolledCourse.save();
    res.status(201).json(savedEnrolledCourse);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get all enrolled courses
router.get("/", async (req, res) => {
  try {
    const enrolledCourses = await EnrolledCourse.find().populate(
      "user course reports"
    ); // Populate to get user, course, and report details
    res.status(200).json(enrolledCourses);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get enrolled course by ID
router.get("/:id", async (req, res) => {
  try {
    const enrolledCourse = await EnrolledCourse.findById(
      req.params.id
    ).populate("user course reports");
    if (!enrolledCourse) {
      return res.status(404).json({ message: "Enrolled Course not found" });
    }
    res.status(200).json(enrolledCourse);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update enrolled course
router.put("/:id", async (req, res) => {
  try {
    const updatedEnrolledCourse = await EnrolledCourse.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );
    if (!updatedEnrolledCourse) {
      return res.status(404).json({ message: "Enrolled Course not found" });
    }
    res.status(200).json(updatedEnrolledCourse);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Delete enrolled course
router.delete("/:id", async (req, res) => {
  try {
    const deletedEnrolledCourse = await EnrolledCourse.findByIdAndDelete(
      req.params.id
    );
    if (!deletedEnrolledCourse) {
      return res.status(404).json({ message: "Enrolled Course not found" });
    }
    res.status(204).send(); // No content to send back
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
