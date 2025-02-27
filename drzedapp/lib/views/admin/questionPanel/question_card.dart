import 'package:drzedapp/views/admin/questionPanel/modify_question_page.dart';
import 'package:flutter/material.dart';
import '../../../models/question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final questionUseCase;
  final VoidCallback onQuestionUpdated;
  final VoidCallback onQuestionDeleted;

  const QuestionCard({
    super.key,
    required this.question,
    required this.questionUseCase,
    required this.onQuestionUpdated,
    required this.onQuestionDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.text,
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
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _modifyQuestion(context),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteQuestion(context),
                ),
              ],
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

void _modifyQuestion(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModifyQuestionPage(
          question: question,
          questionUseCase: questionUseCase,
          onQuestionUpdated: onQuestionUpdated,
        ),
      ),
    );
  }

  void _deleteQuestion(BuildContext context) async {
    await questionUseCase.deleteQuestion(question.id);
    onQuestionDeleted();
  }
}
