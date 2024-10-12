import 'package:flutter/material.dart';

class QAPage extends StatefulWidget {
  const QAPage({Key? key}) : super(key: key);

  @override
  _QAPageState createState() => _QAPageState();
}

class _QAPageState extends State<QAPage> {
  final List<Map<String, String>> faqList = [
    {
      "question": "What is UI/UX design?",
      "answer":
          "UI refers to User Interface, which focuses on how the user interacts with the product. UX refers to User Experience, which focuses on the overall experience the user has when using the product."
    },
    {
      "question": "How do I get started with this course?",
      "answer":
          "You can get started by enrolling in the course and completing the modules one by one. Each module consists of videos, quizzes, and hands-on exercises."
    },
    {
      "question": "Are there any prerequisites for this course?",
      "answer":
          "There are no specific prerequisites. However, a basic understanding of design principles and user behavior will be helpful."
    },
  ];

  final TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background to white

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // FAQ Section
            _buildFAQList(),
            const SizedBox(height: 40),
            // Ask a Question Section
            const Text(
              'Ask a Question',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildQuestionInput(),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {
                if (_questionController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Your question has been submitted!'),
                  ));
                  _questionController.clear(); // Clear input after submission
                }
              },
              child: const Text('Submit Question'),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display the list of FAQs with expandable tiles
  Widget _buildFAQList() {
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), // Disable scrolling inside ListView
      shrinkWrap: true,
      itemCount: faqList.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Text(
            faqList[index]["question"]!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(faqList[index]["answer"]!),
            ),
          ],
        );
      },
    );
  }

  // Widget to display the input field for asking a new question
  Widget _buildQuestionInput() {
    return TextField(
      controller: _questionController,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Enter your question here...',
        filled: true, // Enable filling of the TextField
        fillColor: Colors.grey[300], // Set the fill color to ash
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none, // Remove border line
        ),
      ),
    );
  }
}
