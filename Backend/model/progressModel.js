const express = require('express');
const router = express.Router();


const mongoose = require('mongoose');

// Progress Schema
const ProgressSchema = new mongoose.Schema({
    courseName: {
        type: String,
        required: true,
    },
    progressPercentage: {
        type: Number,
        required: true,
        min: 0,
        max: 100, // Ensure progress is between 0 and 100
    },
    studentId: {
        type: String,
        required: true,
    },
    lastUpdated: {
        type: Date,
        default: Date.now,
    },
});

// Create the Progress model from the schema
const Progress = mongoose.model('Progress', ProgressSchema);

module.exports = Progress;
