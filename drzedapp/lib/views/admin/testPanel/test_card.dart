// test_card.dart
import 'package:flutter/material.dart';
import '../../../models/test.dart';

class TestCard extends StatelessWidget {
  final Test test;

  const TestCard({required this.test, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(Icons.check_circle), // Replace with an appropriate icon
        title: Text(test.title),
        subtitle: Text(test.description),
        onTap: () {
          // Handle tap to navigate to detailed test page or other actions
        },
      ),
    );
  }
}
