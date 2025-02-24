import 'package:flutter/material.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({super.key});

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool _isHovered = false; // Track hover state

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: _isHovered
                ? const Color.fromARGB(255, 200, 200, 230) // Hover color
                : const Color.fromARGB(255, 228, 226, 236), // Default color
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              // Left Image/Icon
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/sample.png', // Replace with your image asset
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Title and Description
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Card Title",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _isHovered ? Colors.black : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "This is some descriptive text about the card. It provides additional details.",
                        style: TextStyle(
                          fontSize: 14,
                          color: _isHovered ? Colors.black87 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Right-side Icon Button
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.black54),
                  onPressed: () {
                    // Add your action here
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
