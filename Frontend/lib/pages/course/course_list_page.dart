import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'add_course_page.dart';

class CourseListPage extends StatefulWidget {
  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  late Future<List<Course>> futureCourses;

  @override
  void initState() {
    super.initState();
    futureCourses = fetchCourses();
  }

  Future<List<Course>> fetchCourses() async {
    final response =
        await http.get(Uri.parse('http://172.20.10.3:5000/api/course'));

    if (response.statusCode == 200) {
      final List<dynamic> courseList = json.decode(response.body);
      return courseList.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCoursePage()),
              ).then((value) {
                if (value == true) {
                  setState(() {
                    futureCourses = fetchCourses();
                  });
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Course>>(
        future: futureCourses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No courses found'));
          } else {
            final courses = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                ),
                itemCount: courses.length,
                itemBuilder: (context, index) => CourseCard(
                  course: courses[index],
                  onPress: () {
                    // Define action on tap
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.course,
    required this.onPress,
  }) : super(key: key);

  final Course course;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.02,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white, // Changed to white
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.network(
                'https://logowik.com/content/uploads/images/udemy-new-20212512.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Image not available'));
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            course.courseName,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
            maxLines: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${course.totalVideo} Videos',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFF7643),
                ),
              ),
              Text(
                '${course.totalTime}h',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF979797),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Course {
  final int id;
  final String courseName;
  final String description;
  final int totalVideo;
  final String totalTime;

  Course({
    required this.id,
    required this.courseName,
    required this.description,
    required this.totalVideo,
    required this.totalTime,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      courseName: json['courseName'],
      description: json['description'],
      totalVideo: json['totalVideo'] ?? 0,
      totalTime: json['totalTime'] ?? 'N/A',
    );
  }
}
