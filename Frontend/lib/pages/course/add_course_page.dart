import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCoursePage extends StatefulWidget {
  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final _formKey = GlobalKey<FormState>();
  late String courseName;
  late String description;
  late String totalTime;
  int? totalVideo; // Make this nullable

  Future<void> _submitCourse() async {
    final response = await http.post(
      Uri.parse('http://172.20.10.3:5000/api/course'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': DateTime.now().millisecondsSinceEpoch,
        'courseName': courseName,
        'description': description,
        'totalVideo': totalVideo ?? 0, // Provide a default value of 0 if null
        'totalTime': totalTime,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Course added successfully!')),
      );
      Navigator.pop(context, true); // Notify the previous page to refresh
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add course')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Course Name',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Color(0xFFEFEFEF), // Set the background color
                ),
                style: TextStyle(color: Colors.black),
                onSaved: (value) => courseName = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a course name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16), // Gap between fields

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  filled: true,
                  fillColor: Color(0xFFEFEFEF), // Set the background color
                ),
                onSaved: (value) => description = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16), // Gap between fields

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Total Videos',
                  filled: true,
                  fillColor: Color(0xFFEFEFEF), // Set the background color
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => totalVideo = int.tryParse(value!) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total videos';
                  } else if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16), // Gap between fields

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Total Time',
                  filled: true,
                  fillColor: Color(0xFFEFEFEF), // Set the background color
                ),
                onSaved: (value) => totalTime = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Gap before the button

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _submitCourse();
                  }
                },
                child: Text('Add Course'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white, // Change background color to white
    );
  }
}
