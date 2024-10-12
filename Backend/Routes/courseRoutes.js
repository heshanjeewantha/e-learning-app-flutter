const express = require("express");
const router = express.Router();
const multer = require("multer");
const path = require("path");
const Course = require("../model/courseModel");

// Set up multer for handling image uploads
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "uploads/"); // Upload images to 'uploads/' directory
  },
  filename: function (req, file, cb) {
    cb(null, `${Date.now()}-${file.originalname}`); // Rename file to avoid conflicts
  },
});

const upload = multer({
  storage: storage,
  fileFilter: function (req, file, cb) {
    const fileTypes = /jpeg|jpg|png/;
    const extname = fileTypes.test(
      path.extname(file.originalname).toLowerCase()
    );
    const mimetype = fileTypes.test(file.mimetype);

    if (extname && mimetype) {
      return cb(null, true);
    } else {
      cb(new Error("Images only!"));
    }
  },
});

// Create a new course (with image upload)
router.post("/", async (req, res) => {
  try {
    const { id, courseName, description, totalVideo, totalTime } = req.body;

    const newCourse = new Course({
      id,
      courseName,
      description,
      totalVideo,
      totalTime,
    });

    await newCourse.save();
    res.status(201).json(newCourse);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get all courses
router.get("/", async (req, res) => {
  try {
    const courses = await Course.find();
    res.json(courses);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// // Get a course by ID
// router.get('/:id', async (req, res) => {
//   try {
//     const course = await Course.findOne({ id: req.params.id });
//     if (!course) {
//       return res.status(404).json({ message: 'Course not found' });
//     }
//     res.json(course);
//   } catch (error) {
//     res.status(500).json({ error: error.message });
//   }
// });

// // Update a course (with image upload)
// router.put('/:id', upload.single('courseImage'), async (req, res) => {
//   try {
//     const course = await Course.findOne({ id: req.params.id });

//     if (!course) {
//       return res.status(404).json({ message: 'Course not found' });
//     }

//     course.courseName = req.body.courseName || course.courseName;
//     course.description = req.body.description || course.description;
//     course.totalVideo = req.body.totalVideo || course.totalVideo;
//     course.totalTime = req.body.totalTime || course.totalTime;
//     course.totalRating = req.body.totalRating || course.totalRating;

//     if (req.file) {
//       course.courseImage = `/uploads/${req.file.filename}`;
//     }

//     await course.save();
//     res.json(course);
//   } catch (error) {
//     res.status(400).json({ error: error.message });
//   }
// });

// // Delete a course
// router.delete('/:id', async (req, res) => {
//   try {
//     const course = await Course.findOneAndDelete({ id: req.params.id });
//     if (!course) {
//       return res.status(404).json({ message: 'Course not found' });
//     }
//     res.json({ message: 'Course deleted' });
//   } catch (error) {
//     res.status(500).json({ error: error.message });
//   }
// });

module.exports = router;
