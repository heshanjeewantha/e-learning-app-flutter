import 'package:core_dashboard/pages/All/CoursePlaylist.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background to white

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Overview Section
            const Text(
              'UI/UX: Designing with a User-Centered Approach',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Course Image
            Center(
              child: Container(
                width: 300,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/video-tutorials.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Course Description
            const Text(
              'This course dives deep into the essentials of User Interface (UI) and User Experience (UX) design. '
              'It covers topics like wireframing, prototyping, user research, and usability testing, all with a focus on a '
              'user-centered approach. By the end, you will be equipped with practical skills to create intuitive and efficient designs.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            // Instructor Section
            const Text(
              'Instructor',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                // Instructor Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/u.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Instructor Name and Bio
                const Expanded(
                  // Ensures content inside the Row adapts to the available space
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'chamodya nethmini',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'UI/UX Expert with over 10 years of experience in the design industry. John has '
                        'worked with top tech companies and has a passion for teaching and sharing knowledge.',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow
                            .clip, // Ensures text doesn't overflow the layout
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Learning Objectives Section
            const Text(
              'What You Will Learn:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const BulletPoint(text: 'User-centered design principles.'),
            const BulletPoint(text: 'Wireframing and prototyping techniques.'),
            const BulletPoint(text: 'Conducting effective user research.'),
            const BulletPoint(text: 'Usability testing and analysis.'),
            const SizedBox(height: 30),
            // Final Note
            const SizedBox(height: 20), // Add spacing
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CoursePlaylist()),
                  );
                },
                child: const Text('Enroll Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(200, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for Bullet Points
class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
