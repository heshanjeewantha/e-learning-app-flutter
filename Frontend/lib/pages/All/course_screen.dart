import 'package:flutter/material.dart';
import 'about_page.dart'; // Create a separate file for AboutPage if needed
import 'qa_page.dart'; // Create a separate file for QAPage if needed
import 'reviews_page.dart'; // Create a separate file for ReviewsPage if needed

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Lessons'),
      ),
      body: Container(
        color: Colors.white, // Set the background of the body to white
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabButton(0, "About"),
                _buildTabButton(1, "Q&A"),
                _buildTabButton(2, "Reviews"),
              ],
            ),
            Expanded(child: _getSelectedTab()),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String title) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedTab = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedTab == index ? Colors.blue : Colors.grey,
      ),
      child: Text(title),
    );
  }

  Widget _getSelectedTab() {
    if (selectedTab == 0) {
      return const AboutPage();
    } else if (selectedTab == 1) {
      return const QAPage();
    } else {
      return const ReviewsPage();
    }
  }
}
