import 'package:drzedapp/views/admin/questionPanel/question_list_page.dart';
import 'package:drzedapp/views/admin/testPanel/test_list_page.dart';
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
            Expanded(child: Lottie.asset('assets/animations/Animation - 1740229235392.json')),
            Expanded(child: Lottie.asset('assets/animations/Animation - 1740229199714.json')),
            const Expanded(flex:1, child: Text(
                "Loading...",
                style: TextStyle(
                  color: Color.fromARGB(255, 227, 56, 44),
                  fontSize: 20,
                ),
                )
              ),
          ],
        ),
      ), 
      //nextScreen: const HomePage(title: "Dr Zed",),
      nextScreen: TestListPage(),
      duration: 100,
      backgroundColor: Colors.white70,
      splashIconSize: 100,
      );
  }
  
}