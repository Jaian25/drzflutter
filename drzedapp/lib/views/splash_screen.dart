import 'package:drzedapp/views/admin/questionPanel/question_list_page.dart';
import 'package:drzedapp/views/admin/testPanel/test_list_page.dart';
import 'package:drzedapp/views/homePanel/home_page.dart';
import 'package:drzedapp/views/homePanel/home_screen.dart';
import 'package:drzedapp/views/loginPanel/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Lottie.asset('assets/animations/Animation - 1740229235392.json'),
            ),
            Expanded(
              flex: 1,
              child: Lottie.asset('assets/animations/Animation - 1740229199714.json'),
            ),
          ],
        ),
      ),
      nextScreen: FutureBuilder<User?>(
        future: FirebaseAuth.instance.currentUser != null ? Future.value(FirebaseAuth.instance.currentUser) : Future.delayed(Duration(seconds: 1), () => null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(color: Colors.white70); // Show a blank screen while waiting
          }
          if (snapshot.hasData) {
            // If the user is logged in, navigate to the HomeScreen
            return HomeScreen();
          } else {
            // If the user is not logged in, navigate to the LoginScreen
            return const LoginScreen();
          }
        },
      ),
      duration: 5000,
      backgroundColor: Colors.white70,
      splashIconSize: 350,
    );
  }
}
