import 'package:drzedapp/views/home/home_card.dart';
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
        body: CustomScrollView(
        //physics: const NeverScrollableScrollPhysics(), // Prevent expansion on scroll
        slivers: [ const
          SliverAppBar(
            backgroundColor: Color.fromARGB(255, 148, 166, 239),
            pinned: true,
            floating: true,
            expandedHeight: 300,
            leading: Icon(Icons.menu, color: Colors.white,),
            flexibleSpace: FlexibleSpaceBar(
              title: Center(child: Text("D R.  Z E D", style: TextStyle(color: Colors.white),)),
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate(
              (context, index) => const HomeCard(),
              childCount: 5
            ),
          ),
        ]
      )
    );
  }
}
