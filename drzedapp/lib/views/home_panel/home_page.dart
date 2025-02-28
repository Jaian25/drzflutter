import 'package:drzedapp/views/home_panel/home_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isExpanded = false; // Track if the AppBar is expanded

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 121, 70, 216),
        shadowColor: Color.fromARGB(255, 0, 3, 4),
        title: Text(
          "drZed",
          style: TextStyle(color: Color.fromARGB(255, 207, 187, 243)),
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => const HomeCard(),
      ),
    );

  }
}
