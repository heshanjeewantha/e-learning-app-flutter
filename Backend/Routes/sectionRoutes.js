const express = require("express");
const router = express.Router();
const Section = require("../model/sectionModel"); // Adjust the path as necessary

// Create a new section
router.post("/", async (req, res) => {
  try {
    const newSection = new Section(req.body);
    const savedSection = await newSection.save();
    res.status(201).json(savedSection);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get all sections
router.get("/", async (req, res) => {
  try {
    const sections = await Section.find().populate("course materials"); // Populate to get course and materials details
    res.status(200).json(sections);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get section by ID
router.get("/:id", async (req, res) => {
  try {
    const section = await Section.findById(req.params.id).populate(
      "course materials"
    );
    if (!section) {
      return res.status(404).json({ message: "Section not found" });
    }
    res.status(200).json(section);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update section
router.put("/:id", async (req, res) => {
  try {
    const updatedSection = await Section.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );
    if (!updatedSection) {
      return res.status(404).json({ message: "Section not found" });
    }
    res.status(200).json(updatedSection);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Delete section
router.delete("/:id", async (req, res) => {
  try {
    const deletedSection = await Section.findByIdAndDelete(req.params.id);
    if (!deletedSection) {
      return res.status(404).json({ message: "Section not found" });
    }
    res.status(204).send(); // No content to send back
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
