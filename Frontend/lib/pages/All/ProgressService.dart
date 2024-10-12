import 'dart:convert';
import 'package:http/http.dart' as http;

class ProgressService {
  // Replace this URL with your actual backend URL
  final String baseUrl =
      "http://172.20.10.3:5000/api/progress"; // For local testing: "http://localhost:3000"

  // Fetch progress data for a specific student
  Future<List> fetchProgress(String studentId) async {
    final response = await http.get(Uri.parse('$baseUrl/progress/$studentId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load progress data');
    }
  }

  // Add new progress
  Future<void> addProgress(String courseName, int progressPercentage) async {
    final response = await http.post(
      Uri.parse('$baseUrl/progress/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'courseName': courseName,
        'progressPercentage': progressPercentage,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add progress');
    }
  }

  // Update existing progress
  Future<void> updateProgress(
      String courseName, String studentId, int progressPercentage) async {
    final response = await http.post(
      Uri.parse('$baseUrl/progress/update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'courseName': courseName,
        'studentId': studentId,
        'progressPercentage': progressPercentage,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update progress');
    }
  }
}
