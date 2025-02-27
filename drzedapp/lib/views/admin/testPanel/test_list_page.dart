// test_list_page.dart
import 'package:flutter/material.dart';
import 'package:drzedapp/data/client/firebase_db_client.dart';
import '../../../models/test.dart';
import '../../../domain/usecases/test_use_case.dart';
import '../../../data/repository/test_repository.dart';
import 'test_card.dart';
import 'add_test_page.dart'; // Import the new AddTestPage

class TestListPage extends StatefulWidget {
  const TestListPage({Key? key}) : super(key: key);

  @override
  State<TestListPage> createState() => _TestListPageState();
}

class _TestListPageState extends State<TestListPage> {
  late TestUseCase _testUseCase;
  List<Test> _testList = [];

  @override
  void initState() {
    super.initState();
    final testRepository = FirebaseDbClient(); // Initialize with your actual repository
    _testUseCase = TestUseCase(testRepository);
    _fetchTests();
  }

  Future<void> _fetchTests() async {
    final tests = await _testUseCase.getTests(); // Fetch tests from the repository
    setState(() {
      _testList = tests;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test List"),
      ),
      body: _testList.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Loading indicator
          : ListView.builder(
              itemCount: _testList.length,
              itemBuilder: (context, index) {
                final test = _testList[index];
                return TestCard(test: test);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to AddTestPage
          bool? newTestAdded = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTestPage()),
          );

          if (newTestAdded == true) {
            _fetchTests(); // Refresh questions after adding a new one
          }
        },
        tooltip: 'Add Test',
        child: const Icon(Icons.add),
      ),
    );
  }
}
