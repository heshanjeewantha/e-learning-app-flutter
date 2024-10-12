const express = require("express");
const router = express.Router();
const Materials = require("../model/materialsModel"); // Adjust the path as necessary

// Create a new material
router.post("/", async (req, res) => {
  try {
    const newMaterial = new Materials(req.body);
    const savedMaterial = await newMaterial.save();
    res.status(201).json(savedMaterial);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get all materials
router.get("/", async (req, res) => {
  try {
    const materials = await Materials.find().populate("section"); // Populate to get section details
    res.status(200).json(materials);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get material by ID
router.get("/:id", async (req, res) => {
  try {
    const material = await Materials.findById(req.params.id).populate(
      "section"
    );
    if (!material) {
      return res.status(404).json({ message: "Material not found" });
    }
    res.status(200).json(material);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update material
router.put("/:id", async (req, res) => {
  try {
    const updatedMaterial = await Materials.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );
    if (!updatedMaterial) {
      return res.status(404).json({ message: "Material not found" });
    }
    res.status(200).json(updatedMaterial);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Delete material
router.delete("/:id", async (req, res) => {
  try {
    const deletedMaterial = await Materials.findByIdAndDelete(req.params.id);
    if (!deletedMaterial) {
      return res.status(404).json({ message: "Material not found" });
    }
    res.status(204).send(); // No content to send back
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
