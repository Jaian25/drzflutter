import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';  // Import the lottie package
import 'user_login_page.dart';
import 'moderator_login_page.dart';
import 'sign_up_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hasNavigated = false; // Track if user has navigated away from login screen

  // Handle the swipe behavior manually
  void _navigateToPage(int pageIndex) {
    setState(() {
      _hasNavigated = true; // Set to true when the user clicks a login button
    });

    // Add your page navigation here
    switch (pageIndex) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserLoginPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ModeratorLoginPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          // Implement swipe logic if necessary
        },
        child: Column(
          children: [
            // Replace the Image with Lottie animation
            SizedBox(
              height: 200,
              child: Lottie.asset('assets/animations/Animation - 1740229235392.json', fit: BoxFit.cover),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLoginButton("Log in as User", Icons.person, Colors.blue, () => _navigateToPage(1)),
                    _buildLoginButton("Log in as Moderator", Icons.security, Colors.orange, () => _navigateToPage(2)),
                    _buildLoginButton("Sign Up", Icons.person_add, Colors.green, () => _navigateToPage(3)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable login button
  Widget _buildLoginButton(String title, IconData icon, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(title, style: const TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }
}
