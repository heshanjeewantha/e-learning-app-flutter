import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:core_dashboard/theme/app_colors.dart'; // Make sure to import your AppColors
import 'package:core_dashboard/theme/app_theme.dart'; // Import your AppTheme if needed

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Notification',
          style: GoogleFonts.inter(
            color: AppColors.titleLight,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                'Mark All as read',
                style: GoogleFonts.inter(
                  color: AppColors.primary,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor:
          AppColors.bgLight, // Change to your theme's background color
      body: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification items
            for (int i = 0; i < 7; i++)
              Column(
                children: [
                  _buildNotificationItem(
                      size, 'Ralph Edwars', '5 min ago', 'Completed'),
                  _buildDivider(),
                  const SizedBox(height: 5),
                ],
              ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildNotificationItem(
      Size size, String name, String timeAgo, String status) {
    return SizedBox(
      width: size.width,
      height: 74,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 30,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.inter(
                      fontSize: 19,
                      color: AppColors.titleLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 55),
                  Text(
                    timeAgo,
                    style: GoogleFonts.inter(
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
              Text(
                status,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      width: double.infinity,
      height: 1,
      color: AppColors.highlightLight, // Use the theme's divider color
    );
  }
}
