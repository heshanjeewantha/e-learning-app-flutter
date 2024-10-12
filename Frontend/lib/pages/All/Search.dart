import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:core_dashboard/theme/app_colors.dart'; // Make sure to import your AppColors
import 'package:core_dashboard/theme/app_theme.dart'; // Import your AppTheme if needed

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = ['Math', 'Physics', 'AI'];
  List<String> categories = ['All', 'Courses', 'Articles', 'Videos', 'Quizzes'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 224, 224, 224), // Set the full-screen background to white
      appBar: AppBar(
        title: Text(
          'Search',
          style: GoogleFonts.inter(color: AppColors.titleLight),
        ),
        backgroundColor: const Color.fromARGB(255, 249, 248,
            255), // Change app bar color to theme's light background
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search courses, topics, etc.',
                hintStyle: GoogleFonts.inter(
                    color: AppColors.textLight), // Set hint text style
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.titleLight),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.titleLight),
                  onPressed: () {
                    _searchController.clear();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
                filled: true,
                fillColor: Colors
                    .white, // Change background color of the search field to white
              ),
              style: GoogleFonts.inter(
                  color: AppColors.titleLight), // Set text style
            ),
            const SizedBox(height: 20),

            // Categories
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      label: Text(
                        categories[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor:
                          AppColors.primary, // Change to theme's primary color
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Recent Searches
            Text(
              'Recent Searches',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.titleLight,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10.0,
              children: recentSearches.map((search) {
                return Chip(
                  label: Text(search, style: GoogleFonts.inter()),
                  backgroundColor: Colors.grey[300],
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Popular Courses (Dummy Data)
            Text(
              'Popular Courses',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.titleLight,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildCourseCard(
                    'Advanced AI Techniques',
                    'Learn about cutting-edge AI technologies...',
                    'assets/images/ui_ux_design.png',
                  ),
                  _buildCourseCard(
                    'Mastering Mathematics',
                    'Step-by-step guide to ace math exams.',
                    'assets/images/development.png',
                  ),
                  _buildCourseCard(
                    'Physics for Engineers',
                    'Physics essentials for engineering students.',
                    'assets/images/coding.png',
                  ),
                  _buildCourseCard(
                    'UI & UX',
                    'UI & UX essentials for students.',
                    'assets/images/ui_ux_design.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(String title, String description, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10.0),
        leading: Image.asset(imagePath, fit: BoxFit.cover, width: 60),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.titleLight,
          ),
        ),
        subtitle: Text(description,
            style: GoogleFonts.inter(color: AppColors.textLight)),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
