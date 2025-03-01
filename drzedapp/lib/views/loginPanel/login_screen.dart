import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';  
import 'user_login_page.dart';
import 'moderator_login_page.dart';
import 'sign_up_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hasNavigated = false;

  void _navigateToPage(int pageIndex) {
    setState(() {
      _hasNavigated = true;
    });

    switch (pageIndex) {
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserLoginPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ModeratorLoginPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600; // Check if screen is small

          return Padding(
            padding: const EdgeInsets.all(20),
            child: isMobile
                ? Center(
                  child: Column( // Mobile layout (Lottie on top, buttons below)
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 250,
                          child: Lottie.asset(
                            'assets/animations/Animation - 1740229235392.json',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLoginButton("Log in as User", Icons.person, Colors.blue, () => _navigateToPage(1)),
                        _buildLoginButton("Log in as Moderator", Icons.security, Colors.blue, () => _navigateToPage(2)),
                        _buildLoginButton("Sign Up", Icons.person_add, Colors.blue, () => _navigateToPage(3)),
                      ],
                    ),
                )
                : Row( // Desktop layout (Lottie on left, buttons on right)
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Lottie.asset(
                          'assets/animations/Animation - 1740229235392.json',
                          fit: BoxFit.contain
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildLoginButton("Log in as User", Icons.person, Colors.blue, () => _navigateToPage(1)),
                            _buildLoginButton("Log in as Moderator", Icons.security, Colors.blue, () => _navigateToPage(2)),
                            _buildLoginButton("Sign Up", Icons.person_add, Colors.blue, () => _navigateToPage(3)),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

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
