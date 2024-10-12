import 'package:core_dashboard/pages/All//Courses.dart';
import 'package:core_dashboard/pages/All/HomeScreen.dart';
import 'package:core_dashboard/pages/All/Messages.dart';
import 'package:core_dashboard/pages/All/Profile.dart';
import 'package:core_dashboard/pages/All/Search.dart';
import 'package:core_dashboard/pages/All/student_progress_page.dart';
import 'package:flutter/material.dart';
import 'package:core_dashboard/theme/app_theme.dart';

void main() {
  runApp(const MainApp()); // Use MyApp as the root widget
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light(context),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  List<bool> state_b = [true, false, false, false, false];
  List<Widget> widgets = [
    const HomeScreen(),
    const Courses(),
    const Search(),
    const Messages(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 235, 237, 245),
        body: Stack(
          children: [
            widgets.elementAt(index),
            Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  width: size.width,
                  height: 80,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(size.width, 80),
                        painter: BNBCustomerPainter(),
                      ),
                      SizedBox(
                        width: size.width,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            state_b[0]
                                ? IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.home,
                                        color: Colors.blue.shade700, size: 35))
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        for (int i = 0;
                                            i < state_b.length;
                                            i++) {
                                          state_b[i] = false;
                                        }
                                        state_b[0] = true;
                                        index = 0;
                                      });
                                    },
                                    icon: const Icon(Icons.home,
                                        color: Colors.grey, size: 35)),
                            state_b[1]
                                ? IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.album_rounded,
                                        color: Colors.blue, size: 35))
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        for (int i = 0;
                                            i < state_b.length;
                                            i++) {
                                          state_b[i] = false;
                                        }
                                        state_b[1] = true;
                                        index = 1;
                                      });
                                    },
                                    icon: const Icon(Icons.album_rounded,
                                        color: Colors.grey, size: 35)),
                            state_b[2]
                                ? IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.search,
                                      color: Colors.blue,
                                      size: 35,
                                    ))
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        for (int i = 0;
                                            i < state_b.length;
                                            i++) {
                                          state_b[i] = false;
                                        }
                                        state_b[2] = true;
                                        index = 2;
                                      });
                                    },
                                    icon: const Icon(Icons.search,
                                        color: Colors.grey, size: 35)),
                            state_b[3]
                                ? IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const StudentProgressPage()),
                                      );
                                    },
                                    icon: const Icon(Icons.message,
                                        color: Colors.blue, size: 35))
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        for (int i = 0;
                                            i < state_b.length;
                                            i++) {
                                          state_b[i] = false;
                                        }
                                        state_b[3] = true;
                                        index = 3;
                                      });
                                    },
                                    icon: const Icon(Icons.message,
                                        color: Colors.grey, size: 35)),
                            state_b[4]
                                ? IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.person,
                                        color: Colors.blue, size: 35))
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        for (int i = 0;
                                            i < state_b.length;
                                            i++) {
                                          state_b[i] = false;
                                        }
                                        state_b[4] = true;
                                        index = 4;
                                      });
                                    },
                                    icon: const Icon(Icons.person,
                                        color: Colors.grey, size: 35)),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}

class BNBCustomerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.65, 0, size.width * 0.40, 20);
    path.quadraticBezierTo(size.width * 0.1, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.8, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
