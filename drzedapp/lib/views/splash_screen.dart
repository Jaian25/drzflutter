import 'package:drzedapp/views/admin/questionPanel/question_list_page.dart';
import 'package:drzedapp/views/admin/testPanel/test_list_page.dart';
import 'package:drzedapp/views/home_panel/home_page.dart';
import 'package:drzedapp/views/home_panel/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Column(
          children: [
            Expanded(flex: 2, child: Lottie.asset('assets/animations/Animation - 1740229235392.json')),
            Expanded(flex: 1, child: Lottie.asset('assets/animations/Animation - 1740229199714.json')),
          ],
        ),
      ), 
      nextScreen: HomeScreen(),
      // nextScreen: TestListPage(),
      // nextScreen: QuestionListPage(),
      duration: 5000,
      backgroundColor: Colors.white70,
      splashIconSize: 350,
      );
  }
  
}