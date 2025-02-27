import 'package:flutter/material.dart';
import '../../models/question.dart';
import '../../domain/usecases/question_use_case.dart';

class ModifyQuestionPage extends StatefulWidget {
  final Question question;
  final QuestionUseCase questionUseCase;
  final VoidCallback onQuestionUpdated;

  const ModifyQuestionPage({
    super.key,
    required this.question,
    required this.questionUseCase,
    required this.onQuestionUpdated,
  });

  @override
  _ModifyQuestionPageState createState() => _ModifyQuestionPageState();
}

class _ModifyQuestionPageState extends State<ModifyQuestionPage> {
  late TextEditingController _textController;
  List<TextEditingController>? _optionControllers;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.question.text);
    if (widget.question is SingleChoiceQuestion || widget.question is MultipleChoiceQuestion) {
      _optionControllers = (widget.question as dynamic)
          .options
          .map<TextEditingController>((option) => TextEditingController(text: option))
          .toList();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _optionControllers?.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _saveQuestion() async {
    Question updatedQuestion;
    if (widget.question is TextQuestion) {
      updatedQuestion = TextQuestion(id: widget.question.id, text: _textController.text);
    } else if (widget.question is SingleChoiceQuestion) {
      updatedQuestion = SingleChoiceQuestion(
        id: widget.question.id,
        text: _textController.text,
        options: _optionControllers!.map((c) => c.text).toList(),
      );
    } else if (widget.question is MultipleChoiceQuestion) {
      updatedQuestion = MultipleChoiceQuestion(
        id: widget.question.id,
        text: _textController.text,
        options: _optionControllers!.map((c) => c.text).toList(),
      );
    } else {
      return;
    }

    await widget.questionUseCase.updateQuestion(updatedQuestion);
    widget.onQuestionUpdated();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modify Question')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Question Text'),
            ),
            const SizedBox(height: 10),
            if (_optionControllers != null) ...[
              const Text('Options', style: TextStyle(fontWeight: FontWeight.bold)),
              for (int i = 0; i < _optionControllers!.length; i++)
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _optionControllers![i],
                        decoration: InputDecoration(labelText: 'Option ${i + 1}'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _optionControllers!.removeAt(i);
                        });
                      },
                    ),
                  ],
                ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _optionControllers!.add(TextEditingController());
                  });
                },
                child: const Text('Add Option'),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveQuestion,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
