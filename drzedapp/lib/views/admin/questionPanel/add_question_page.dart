import 'package:drzedapp/data/client/firebase_db_client.dart';
import 'package:drzedapp/data/repository/question_repository.dart';
import 'package:flutter/material.dart';
import '../../../domain/usecases/question_use_case.dart';
import '../../../models/question.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({super.key});

  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  late QuestionUseCase _questionUseCase;
  late QuestionRepository _questionRepository;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  String _questionType = 'text'; // Default question type
  final List<String> _options = [];

  @override
  void initState() {
    super.initState();
    _questionRepository = FirebaseDbClient();
    _questionUseCase = QuestionUseCase(_questionRepository);
  }

  void _addOption() {
    setState(() {
      _options.add('');
    });
  }

  void _removeOption(int index) {
    setState(() {
      _options.removeAt(index);
    });
  }

  void _updateOption(int index, String value) {
    _options[index] = value;
  }

  Future<void> _submitQuestion() async {
    if (!_formKey.currentState!.validate()) return;

    String questionText = _textController.text.trim();
    String questionId = DateTime.now().millisecondsSinceEpoch.toString(); // Unique ID

    Question newQuestion;
    if (_questionType == 'text') {
      newQuestion = TextQuestion(id: questionId, text: questionText);
    } else if (_questionType == 'single_choice') {
      newQuestion = SingleChoiceQuestion(id: questionId, text: questionText, options: _options);
    } else {
      newQuestion = MultipleChoiceQuestion(id: questionId, text: questionText, options: _options);
    }

    try {
      await _questionUseCase.addQuestion(newQuestion);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Question added successfully')));
      Navigator.pop(context, true); // Return true to refresh the question list
    } catch (error) {
      print("[LOG] Error adding question: $error");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to add question')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Question')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _textController,
                decoration: const InputDecoration(labelText: 'Question Text'),
                validator: (value) => value == null || value.trim().isEmpty ? 'Enter a question' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _questionType,
                items: const [
                  DropdownMenuItem(value: 'text', child: Text('Text Question')),
                  DropdownMenuItem(value: 'single_choice', child: Text('Single Choice Question')),
                  DropdownMenuItem(value: 'multiple_choice', child: Text('Multiple Choice Question')),
                ],
                onChanged: (value) {
                  setState(() {
                    _questionType = value!;
                    _options.clear(); // Reset options when changing type
                  });
                },
                decoration: const InputDecoration(labelText: 'Question Type'),
              ),
              if (_questionType != 'text') ...[
                const SizedBox(height: 16),
                const Text('Options:', style: TextStyle(fontWeight: FontWeight.bold)),
                for (int i = 0; i < _options.length; i++)
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _options[i],
                          onChanged: (value) => _updateOption(i, value),
                          decoration: InputDecoration(labelText: 'Option ${i + 1}'),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => _removeOption(i),
                      ),
                    ],
                  ),
                TextButton.icon(
                  onPressed: _addOption,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Option'),
                ),
              ],
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitQuestion,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
