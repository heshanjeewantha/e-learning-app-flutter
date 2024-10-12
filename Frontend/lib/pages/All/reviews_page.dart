import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Import the rating bar package
import 'review_form.dart'; // Assuming review form is separated

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  List reviews = [];

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    final response =
        await http.get(Uri.parse('http://172.20.10.3:5000/api/reviews'));
    if (response.statusCode == 200) {
      setState(() {
        reviews = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use Scaffold to take full screen and support app bar, etc.

      body: Container(
        // Use Container to set the background color
        color: Colors.white, // Set background color to white
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: RatingBarIndicator(
                      rating: reviews[index]['rating'].toDouble(),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5, // Number of stars
                      itemSize: 25.0, // Size of the stars
                      direction: Axis.horizontal,
                    ),
                    subtitle: Text(reviews[index]['review']),
                  );
                },
              ),
            ),
            const ReviewForm(),
          ],
        ),
      ),
    );
  }
}
