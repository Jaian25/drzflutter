import 'package:drzedapp/data/client/firebase_db_client.dart';
import 'package:flutter/material.dart';
import '../../models/test.dart';
import '../../data/repository/test_repository.dart';
import '../../domain/usecases/test_use_case.dart';
import 'cards/test_card.dart';

class TestsPage extends StatefulWidget {
  @override
  _TestsPageState createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
  late TestUseCase _testUseCase;
  List<Test> _allTests = [];
  List<Test> _filteredTests = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _testUseCase = TestUseCase(FirebaseDbClient());
    _fetchTests();
    _searchController.addListener(_filterTests);
  }

  Future<void> _fetchTests() async {
    List<Test> tests = await _testUseCase.getTests();
    setState(() {
      _allTests = tests;
      _filteredTests = tests;
    });
  }

  void _filterTests() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTests = _allTests.where((test) {
        return test.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tests"),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search Tests...",
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Test Cards Grid View
          Expanded(
            child: _filteredTests.isEmpty
                ? Center(child: Text("No tests found"))
                : GridView.builder(
                    padding: EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Adjust as needed
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: 3, // Ensures square shape
                    ),
                    itemCount: _filteredTests.length,
                    itemBuilder: (context, index) {
                      return TestCard(test: _filteredTests[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
