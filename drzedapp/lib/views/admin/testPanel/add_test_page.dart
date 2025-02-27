// add_test_page.dart
import 'package:flutter/material.dart';
import '../../../data/client/firebase_db_client.dart';
import '../../../models/test.dart';
import '../../../domain/usecases/test_use_case.dart';
import '../../../data/repository/test_repository.dart';

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

  @override
  void initState() {
    super.initState();
    final testRepository = FirebaseDbClient(); // Initialize with your actual repository
    _testUseCase = TestUseCase(testRepository);
  }

  Future<void> _submitForm() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final iconUri = _iconUriController.text;

    if (title.isEmpty || description.isEmpty || iconUri.isEmpty) {
      // Show a snackbar or alert if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    // Create a new test object
    final newTest = Test(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
      iconUri: iconUri,
      title: title,
      description: description,
      questionariesId: [],
    );

    // Add the new test
    await _testUseCase.addTest(newTest);

    // Redirect back to the TestListPage
    Navigator.pop(context, true);
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
              onPressed: _submitForm,
              child: const Text('Add Test'),
            ),
          ],
        ),
      ),
    );
  }
}
