import 'package:core_dashboard/pages/dashboard/widgets/overview.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:flutter/material.dart';

import '../../shared/constants/ghaps.dart';
import 'widgets/comments.dart';
import 'widgets/get_more_customers.dart';
import 'widgets/popular_Course.dart';
import 'widgets/pro_tips.dart';
import 'widgets/refund_request.dart';
import '../course/course_list_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!Responsive.isMobile(context)) gapH24,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Dashboard",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the CourseListPage when button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CourseListPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "View Course",
                style: TextStyle(
                  color: const Color.fromARGB(255, 6, 1, 46),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        gapH20,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const Overview(),
                  gapH16,
                  const GetMoreCustomers(),
                  if (Responsive.isMobile(context))
                    const Column(
                      children: [
                        gapH16,
                        Comments(),
                        gapH16,
                      ],
                    ),
                ],
              ),
            ),
            if (!Responsive.isMobile(context)) gapW16,
            if (!Responsive.isMobile(context))
              const Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Comments(),
                    gapH16,
                  ],
                ),
              ),
          ],
        )
      ],
    );
  }
}
