import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:core_dashboard/theme/app_theme.dart';
import 'package:core_dashboard/pages/entry_point.dart'; // Import DashboardPage
import 'package:core_dashboard/main.dart'; // Import MainPage (main.dart)

import 'package:core_dashboard/shared/constants/config.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/extensions.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/social_login_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _signIn() {
    String email = emailController.text;
    String password = passwordController.text;

    // Check credentials
    if (email == 'admin@gmail.com' && password == '123') {
      // Navigate to DashboardPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EntryPoint()),
      );
    } else if (email == 'user@gmail.com' && password == '123') {
      // Navigate to MainPage (main.dart)
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const MainApp()), // Assuming this is the main.dart
      );
    } else {
      // Show error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Invalid email or password.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: 296,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDefaults.padding * 1.5,
                      ),
                      child: Image.asset('assets/logo/log.png'),
                    ),
                    Text(
                      'Sign In',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    gapH24,
                    Text(
                      'Sign up with Open account',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    gapH24,
                    SocialLoginButton(
                      onGoogleLoginPressed: () {},
                      onAppleLoginPressed: () {},
                    ),
                    gapH24,
                    const Divider(),
                    gapH24,
                    Text(
                      'Or continue with email address',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    gapH16,

                    // EMAIL TEXT FIELD
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true, // Enable the fill color
                        fillColor:
                            Color(0xFFEEEEEE), // Set the background color
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Your email',
                        border: OutlineInputBorder(
                          // Optional: to add a border around the field
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                          borderSide: BorderSide.none, // No border
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // PASSWORD TEXT FIELD
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true, // Enable the fill color
                        fillColor:
                            Color(0xFFEEEEEE), // Set the background color
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          // Optional: to add a border around the field
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                          borderSide: BorderSide.none, // No border
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // SIGN IN BUTTON
                    SizedBox(
                      width: 296,
                      child: ElevatedButton(
                        onPressed: _signIn,
                        child: const Text('Sign in'),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // FOOTER TEXT
                    Text(
                      'This site is protected by reCAPTCHA and the Google Privacy Policy.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 24),

                    // SIGNUP TEXT
                    Row(
                      children: [
                        Text(
                          'Don’t have an account?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () => context.go('/register'),
                          child: const Text('Sign up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
