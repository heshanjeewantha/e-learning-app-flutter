import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  String baseUrl =
      'http://172.20.10.3:5000/api/progress'; // Replace with your API endpoint
  List<dynamic> progressData = []; // To store all progress data
  bool isLoading = false; // To show a loading indicator

  // Fetch all progress data
  Future<void> fetchAllProgress() async {
    setState(() {
      isLoading = true;
    });

    var url = Uri.parse(baseUrl);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        progressData = json.decode(response.body);
        isLoading = false;
      });
    } else {
      showSnackbar('Failed to fetch progress data');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Show a snackbar
  void showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    super.initState();
    fetchAllProgress(); // Fetch all progress data when the screen is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      appBar: AppBar(
        title: const Text('Student Progress'),
        backgroundColor: const Color.fromARGB(255, 87, 103, 248),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back button icon
          onPressed: () {
            Navigator.pop(context); // Pop the current screen off the stack
          },
        ),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/web.png', // Your image path
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),

          // Progress Button to return to Courses
          TextButton(
            onPressed: () {
              Navigator.pop(context); // This will return to the previous screen
            },
            child: const Text(
              'Progress', // Button Text
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue, // Customize color as needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Show loading indicator when data is being fetched
          isLoading
              ? const CircularProgressIndicator()
              : progressData.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: progressData.length,
                        itemBuilder: (context, index) {
                          var item = progressData[index];
                          double progress = item['progressPercentage'] / 100;

                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Course name with highlighted text color
                                  Text(
                                    item['courseName'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  // Progress as a bar with color and animation
                                  LinearProgressIndicator(
                                    value: progress,
                                    minHeight: 10,
                                    backgroundColor: Colors.grey[300],
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                      Colors.green,
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  // Progress percentage highlighted
                                  Text(
                                    'Progress: ${item['progressPercentage']}%',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 5),

                                  // Last updated in gray color
                                  Text(
                                    'Last Updated: ${item['lastUpdated']}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const Text(
                      'No progress data available',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
        ],
      ),
    );
  }
}
