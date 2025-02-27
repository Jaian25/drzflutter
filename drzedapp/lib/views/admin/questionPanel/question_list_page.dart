import 'package:drzedapp/data/client/firebase_db_client.dart';
import 'package:flutter/material.dart';
import '../../../data/repository/question_repository.dart';
import '../../../domain/usecases/question_use_case.dart';
import '../../../models/question.dart';
import 'add_question_page.dart';
import 'question_card.dart';

class QuestionListPage extends StatefulWidget {
  const QuestionListPage({super.key});

  @override
  _QuestionListPageState createState() => _QuestionListPageState();
}

class _QuestionListPageState extends State<QuestionListPage> {
  late QuestionUseCase _questionUseCase;
  late QuestionRepository _questionRepository;
  List<Question> _questions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _questionRepository = FirebaseDbClient();
    _questionUseCase = QuestionUseCase(_questionRepository); // Use the repository implementation
    _fetchQuestions();
  }

  void _fetchQuestions() async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Question> fetchedQuestions = await _questionUseCase.getQuestions();
      setState(() {
        _questions = fetchedQuestions;
        _isLoading = false;
      });
    } catch (error) {
      print("[LOG] Error fetching questions: $error");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Question List')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _questions.isEmpty
              ? const Center(child: Text("No questions available."))
              : ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    return QuestionCard(question: _questions.elementAt(index), questionUseCase: _questionUseCase, onQuestionUpdated: () { _fetchQuestions(); }, onQuestionDeleted: () { _fetchQuestions(); },);
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? newQuestionAdded = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddQuestionPage()),
          );

          if (newQuestionAdded == true) {
            _fetchQuestions(); // Refresh questions after adding a new one
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
