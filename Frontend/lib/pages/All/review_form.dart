import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';

class ReviewForm extends StatefulWidget {
  const ReviewForm({Key? key}) : super(key: key);

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 0;
  String _review = "";
  var uuid = const Uuid(); // Initialize UUID

  Future<void> submitReview() async {
    final response = await http.post(
      Uri.parse('http://172.20.10.3:5000/api/reviews'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': uuid.v4(),
        'rating': _rating,
        'review': _review,
        'user': '66ffa837e4f00df8f47de322', // Replace with actual user ID
        'course': '66ffa74e0a4d5cfff06beba3', // Replace with actual course ID
      }),
    );
    print(response.body);

    if (response.statusCode == 201) {
      print('Review submitted');
    } else {
      throw Exception('Failed to submit review');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    // Get the screen size and orientation
    var screenSize = MediaQuery.of(context).size;
    var isPortrait = screenSize.height > screenSize.width;

    return Container(
      // Wrap in a Container for the background color
      color: Colors.white, // Set background color to white
      padding: EdgeInsets.symmetric(
        horizontal: isPortrait
            ? 16.0
            : screenSize.width * 0.2, // More padding in landscape mode
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Review',
                filled: true, // Enable filling the background color
                fillColor: const Color.fromARGB(
                    255, 228, 228, 228), // Set the background color to white
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Colors.grey.shade400), // Ash border color
                ),
              ),
              onChanged: (value) => _review = value,
              maxLines: isPortrait
                  ? 4
                  : 2, // More lines in portrait mode for better usability
            ),
            const SizedBox(height: 20), // Add spacing
            DropdownButtonFormField<int>(
              value: _rating,
              onChanged: (value) => setState(() {
                _rating = value!;
              }),
              items: List.generate(6, (index) {
                return DropdownMenuItem(
                  value: index,
                  child: Text('Rating: $index'),
                );
              }),
              decoration: InputDecoration(
                labelText: 'Rating',
                filled: true, // Enable filling the background color
                fillColor: const Color.fromARGB(
                    255, 228, 228, 228), // Set the background color to white
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Colors.grey.shade400), // Ash border color
                ),
              ),
            ),

            const SizedBox(height: 20), // Add spacing
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    submitReview();
                  }
                },
                child: const Text('Submit Review'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(
                    screenSize.width *
                        (isPortrait
                            ? 0.8
                            : 0.4), // Button adapts to screen width
                    40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
