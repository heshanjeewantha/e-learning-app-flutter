import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:core_dashboard/pages/dashboard/widgets/comment_item.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/shared/widgets/section_title.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:core_dashboard/models/feedback_model.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  List<FeedbackModel> feedbackList = [];
  bool isLoading = true;
  String errorMessage = '';

  final String apiUrl = 'http://172.20.10.3:5000/api/feedbacks';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      if (mounted) {
        fetchFeedbacks();
      }
    });
  }

  Future<void> fetchFeedbacks() async {
    try {
      print('Attempting to fetch feedbacks from: $apiUrl');
      final response = await http.get(Uri.parse(apiUrl));
      print('Response received. Status code: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> feedbackData = json.decode(response.body);
        print(
            'Successfully decoded JSON. Number of items: ${feedbackData.length}');
        setState(() {
          try {
            feedbackList = feedbackData.map((data) {
              print('Processing feedback item: $data');
              return FeedbackModel.fromJson(data);
            }).toList();
            print('Successfully parsed ${feedbackList.length} feedback items');
            isLoading = false;
          } catch (e) {
            print('Error parsing feedback data: $e');
            errorMessage = 'Error parsing feedback data: $e';
            feedbackList = [];
            isLoading = false;
          }
        });
      } else {
        throw Exception(
            'Failed to load feedback. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching feedback: $error');
      setState(() {
        isLoading = false;
        errorMessage =
            'Failed to load feedback. Please try again later. Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius: BorderRadius.all(
          Radius.circular(AppDefaults.borderRadius),
        ),
      ),
      padding: const EdgeInsets.all(AppDefaults.padding * 0.75),
      child: Column(
        children: [
          gapH8,
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDefaults.padding * 0.5,
            ),
            child: SectionTitle(
              title: "Feedbacks",
              color: AppColors.secondaryPaleYellow,
            ),
          ),
          gapH16,
          if (isLoading)
            CircularProgressIndicator()
          else if (errorMessage.isNotEmpty)
            Text(errorMessage, style: TextStyle(color: Colors.red))
          else if (feedbackList.isEmpty)
            Text("No feedback available.")
          else
            ListView.builder(
              itemCount: feedbackList.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                final feedback = feedbackList[index];
                return CommentItem(
                  name: feedback.name,
                  username: feedback.username,
                  time: feedback.time,
                  product: feedback.product,
                  comment: feedback.comment,
                  imageSrc: feedback.imageSrc,
                  onProfilePressed: () {},
                  onProductPressed: () {},
                );
              },
            ),
          gapH8,
        ],
      ),
    );
  }
}
