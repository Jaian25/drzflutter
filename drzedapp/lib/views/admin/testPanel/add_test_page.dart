import 'package:flutter/material.dart';
import '../../../data/client/firebase_db_client.dart';
import '../../../models/test.dart';
import '../../../models/question.dart';
import '../../../domain/usecases/test_use_case.dart';
import '../../../domain/usecases/question_use_case.dart';
import '../../../data/repository/test_repository.dart';
import '../../../data/repository/question_repository.dart';

class AddTestPage extends StatefulWidget {
  const AddTestPage({super.key});

  @override
  State<AddTestPage> createState() => _AddTestPageState();
}

class _AddTestPageState extends State<AddTestPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _iconUriController = TextEditingController();

  late TestUseCase _testUseCase;
  late QuestionUseCase _questionUseCase;

  List<Question> _questions = [];
  List<String> _selectedQuestions = [];

  @override
  void initState() {
    super.initState();
    final testRepository = FirebaseDbClient();
    _testUseCase = TestUseCase(testRepository);
    final questionRepository = FirebaseDbClient();
    _questionUseCase = QuestionUseCase(questionRepository);
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    final questions = await _questionUseCase.getQuestions();
    setState(() {
      _questions = questions;
    });
  }

  Future<void> _submitForm() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final iconUri = _iconUriController.text;

    if (title.isEmpty || description.isEmpty || iconUri.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    // Create a new test object
    final newTest = Test(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      iconUri: iconUri,
      title: title,
      description: description,
      questionariesId: _selectedQuestions,
    );

    // Add the new test
    await _testUseCase.addTest(newTest);

    // Redirect back to the TestListPage
    Navigator.pop(context, true);
  }

  Future<void> _showAddQuestionsDialog() async {
    final selectedQuestionIds = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Questions'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  children: _questions.map((question) {
                    return CheckboxListTile(
                      title: Text(question.text),
                      value: _selectedQuestions.contains(question.id),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedQuestions.add(question.id);
                          } else {
                            _selectedQuestions.remove(question.id);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, _selectedQuestions);
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );

    if (selectedQuestionIds != null) {
      setState(() {
        _selectedQuestions = selectedQuestionIds;
      });
    }
  }

  void _removeQuestion(String questionId) {
    setState(() {
      _selectedQuestions.remove(questionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Test Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Test Description'),
            ),
            TextField(
              controller: _iconUriController,
              decoration: const InputDecoration(labelText: 'Icon URI'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showAddQuestionsDialog,
              child: const Text('Select Questions'),
            ),
            const SizedBox(height: 20),
            // Show selected questions in cards
            if (_selectedQuestions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Selected Questions:'),
                    for (var questionId in _selectedQuestions)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Card(
                          elevation: 3,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10.0),
                            title: Text(
                              _questions.firstWhere((q) => q.id == questionId).text,
                              style: const TextStyle(fontSize: 16),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () => _removeQuestion(questionId),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Add Test'),
            ),
          ],
        ),
      ),
    );
  }
}
