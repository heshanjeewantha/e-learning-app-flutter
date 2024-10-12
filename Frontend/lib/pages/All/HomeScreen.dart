import 'package:core_dashboard/pages/All/AllCourses.dart';
import 'package:core_dashboard/pages/All/Filter.dart';
import 'package:core_dashboard/pages/All/course_screen.dart';
import 'package:flutter/material.dart';
import 'progress_screen.dart';
import 'package:go_router/go_router.dart'; // For routing
import 'package:core_dashboard/pages/authentication/sign_in_page.dart'; // Import the SignInPage

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color _color = Colors.white;
  final bool _color_s = false;
  final mail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              /// Greeting and Logout Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hello Kasun!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  /// Logout Button
                  IconButton(
                    icon: const Icon(Icons.logout,
                        color: Color.fromARGB(255, 212, 46, 46)),
                    onPressed: () {
                      // Navigate to the SignInPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const SignInPage()),
                      );
                    },
                  ),
                ],
              ),

              const Text(
                'Find your course',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              Row(
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: const Offset(5.0, 5.0),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: mail,
                        decoration: InputDecoration(
                          filled: true, // Enable the fill color
                          fillColor:
                              Colors.white, // Set the background color to white
                          prefixIcon: Icon(
                            Icons.search,
                            size: 30,
                            color: Colors.grey,
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 500));
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) => Filter()));
                      },
                      child: Container(
                        width: 60,
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 23, 145, 245),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: 33,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: 190,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 107, 140, 254),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hurry Up',
                          style: TextStyle(color: Colors.white54, fontSize: 15),
                        ),
                        const Text(
                          'Enroll Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 37,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'For all courses',
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: 130,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 238, 101, 10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              'Get  Now',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    right: 5,
                    child: Image.asset(
                      'assets/images/alarm-clock.png',
                      width: 160,
                      height: 160,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Courses',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () async {
                      await Future.delayed(const Duration(milliseconds: 500));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const AllCourses()));
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 10,
                runSpacing: 15,
                children: [
                  courseCard(
                    image: 'assets/images/ui_ux_design.png',
                    title: 'UX/UI Design',
                    duration: '5h 30 min',
                    rating: '4.9 (522 reviews)',
                  ),
                  courseCard(
                    image: 'assets/images/web-development.png',
                    title: 'Web Development',
                    duration: '5h 30 min',
                    rating: '4.9 (522 reviews)',
                  ),
                  courseCard(
                    image: 'assets/images/development.png',
                    title: 'Mobile Development',
                    duration: '5h 30 min',
                    rating: '4.9 (522 reviews)',
                  ),
                  courseCard(
                    image: 'assets/images/python.png',
                    title: 'Python From A to Z',
                    duration: '5h 30 min',
                    rating: '4.9 (522 reviews)',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget courseCard({
    required String image,
    required String title,
    required String duration,
    required String rating,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => const CourseScreen()),
        );
      },
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Image.asset(image, width: 100, height: 120),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.grey, size: 20),
                Text(duration, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange),
                Text(rating, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
