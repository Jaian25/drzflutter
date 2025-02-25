import 'package:drzedapp/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBUbF47Sw1QeoJuY-7IVJaLQ7ekdLFccpw",
        authDomain: "drzed-50e5b.firebaseapp.com",
        projectId: "drzed-50e5b",
        storageBucket: "drzed-50e5b.firebasestorage.app",
        messagingSenderId: "672139682448",
        appId: "1:672139682448:web:c31f6da2fe9d6b88676e15",
        databaseURL: "https://drzed-50e5b-default-rtdb.asia-southeast1.firebasedatabase.app"
      )
  );
  print("firebase intiliaze app");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}