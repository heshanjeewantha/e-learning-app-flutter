import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // For chart
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'progress_screen.dart'; // Import the ProgressScreen

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  String selectedButton = 'Progress';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background to white
      appBar: AppBar(
        title: const Text('Student Progress Tracking'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: Colors.white, // Ensure the body is also white
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section with Image
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30, // Radius for the circular image
                    backgroundImage: AssetImage(
                        'assets/images/u.png'), // Load image from assets
                  ),
                  const SizedBox(width: 10), // Space between image and text
                  Text(
                    'Chamodya Silva', // Placeholder for student name
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Top Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavigationButton('Progress'),
                _buildNavigationButton('Overview'),
                _buildNavigationButton('Settings'),
              ],
            ),
            const Divider(),

            // Dynamic content based on selected button
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildSelectedContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build navigation buttons
  Widget _buildNavigationButton(String buttonName) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedButton = buttonName;
          if (selectedButton == 'Overview') {
            // Navigate to ProgressScreen when Overview is selected
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProgressScreen()),
            );
          }
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor:
            selectedButton == buttonName ? Colors.white : Colors.black,
        backgroundColor:
            selectedButton == buttonName ? Colors.blueAccent : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(buttonName),
    );
  }

  // Main content based on button selection
  Widget _buildSelectedContent() {
    switch (selectedButton) {
      case 'Progress':
        return _buildProgressContent();
      case 'Overview':
        return const SizedBox
            .shrink(); // Empty or some default content as the navigation happens on button press
      case 'Settings':
        return _buildSettingsContent();
      default:
        return _buildProgressContent();
    }
  }

  // 1. Progress Content
  Widget _buildProgressContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add an image to the Progress section
        Image.asset(
          'assets/images/po.jpeg', // Path to your image
          height: 150, // Adjust the height as needed
          width: double.infinity, // Make it full width
          fit: BoxFit.cover, // Cover the area
        ),
        const SizedBox(height: 10),
        Text(
          'Overall Progress   70%',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: 0.7, // Example progress value
          minHeight: 10,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
        ),
        const SizedBox(height: 50),

        // Bar Chart
        Text(
          'Course Completion Rate',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent[700],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(fromY: 0, color: Colors.blue, toY: 8),
                  ],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(fromY: 0, color: Colors.blue, toY: 7),
                  ],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(fromY: 0, color: Colors.blue, toY: 5),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 3. Settings Content
  Widget _buildSettingsContent() {
    return const Center(
      child: Text(
        'Settings Page - Customize your preferences',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
