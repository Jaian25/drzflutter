import 'package:drzedapp/models/question.dart';

abstract class QuestionRepository {
  Future<void> addQuestion(Question question);
  Future<void> updateQuestion(Question question);
  Future<void> deleteQuestion(String questionId);
  Future<List<Question>> getQuestions();
  Future<Question?> getQuestionById(String questionId);
}
