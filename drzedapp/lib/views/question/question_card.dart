import 'package:flutter/material.dart';
import '../../models/question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;

  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.text, // Now using the correct Question class property
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            if (question is SingleChoiceQuestion || question is MultipleChoiceQuestion) ...[
              const Text("Options:", style: TextStyle(fontWeight: FontWeight.bold)),
              for (var option in (question as dynamic).options) Text("- $option"),
            ],
            const SizedBox(height: 5),
            Text(
              "Type: ${_getQuestionType(question)}",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  String _getQuestionType(Question question) {
    if (question is TextQuestion) return 'Text';
    if (question is SingleChoiceQuestion) return 'Single Choice';
    if (question is MultipleChoiceQuestion) return 'Multiple Choice';
    return 'Unknown';
  }
}
