// student_progress_page.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'ProgressService.dart';

class StudentProgressPage extends StatefulWidget {
  const StudentProgressPage({Key? key}) : super(key: key);

  @override
  _StudentProgressPageState createState() => _StudentProgressPageState();
}

class _StudentProgressPageState extends State<StudentProgressPage> {
  ProgressService progressService = ProgressService();
  List progressList = [];
  String studentId = '1001'; // Example studentId
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProgressData();
  }

  // Fetching progress data
  fetchProgressData() async {
    try {
      List data = await progressService.fetchProgress(studentId);
      setState(() {
        progressList = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Progress'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  // Tablet View
                  return Row(
                    children: [
                      Expanded(child: buildProgressChart(context)),
                      Expanded(child: buildProgressDetailsTable(context)),
                    ],
                  );
                } else {
                  // Mobile View
                  return ListView(
                    children: [
                      buildProgressChart(context),
                      buildProgressDetailsTable(context),
                    ],
                  );
                }
              },
            ),
    );
  }

  // Widget to display bar chart for course progress
  Widget buildProgressChart(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Course Completion Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: progressList
                      .map(
                        (progress) => BarChartGroupData(
                          x: progressList.indexOf(progress),
                          barRods: [
                            BarChartRodData(
                              toY: progress['progressPercentage'].toDouble(),
                              color: Colors.blueAccent,
                              width: 20,
                            ),
                          ],
                          showingTooltipIndicators: [0],
                        ),
                      )
                      .toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < progressList.length) {
                            return Text(
                              progressList[value.toInt()]['courseName'],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display detailed progress in a table
  Widget buildProgressDetailsTable(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Course Progress Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Course Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Progress (%)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Last Updated',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: progressList
                    .map(
                      (progress) => DataRow(cells: [
                        DataCell(Text(progress['courseName'])),
                        DataCell(Text('${progress['progressPercentage']}%')),
                        DataCell(Text(
                            '${DateTime.parse(progress['lastUpdated']).toLocal()}')),
                      ]),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
