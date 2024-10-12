// server.js
const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const cors = require("cors");
const feedbackRoutes = require("./Routes/feedbackRoutes");
const courseRoutes = require("./Routes/courseRoutes");
const userRoutes = require("./Routes/userRoutes");
const categoryRoutes = require("./Routes/categoryRoutes");
const sectionRoutes = require("./Routes/sectionRoutes");
const materialsRoutes = require("./Routes/materialsRoutes");
const enrolledCourseRoutes = require("./Routes/enrolledCourseRoutes");
const reviewRoutes = require("./Routes/reviewRoutes");
const wishlistRoutes = require("./Routes/authRoutes");
const authRoutes = require("./Routes/authRoutes");
const progressRoute = require("./Routes/progressRoute");

dotenv.config();
const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use("/api/feedbacks", feedbackRoutes);
app.use("/api/course", courseRoutes);
app.use("/api/users", userRoutes);
app.use("/api/categories", categoryRoutes);
app.use("/api/sections", sectionRoutes);
app.use("/api/materials", materialsRoutes);
app.use("/api/enrolledCourses", enrolledCourseRoutes);
app.use("/api/reviews", reviewRoutes);
app.use("/api/wishlists", wishlistRoutes);
app.use("/api/auth", authRoutes);
app.use("/api/progress", progressRoute);
// Database connection
mongoose
  .connect(process.env.MONGODB_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => console.log("MongoDB connected"))
  .catch((err) => console.log(err));

// Start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
