import '../../data/repository/question_repository.dart';
import '../../models/question.dart';

class QuestionUseCase {
  final QuestionRepository _questionRepository;

  QuestionUseCase(this._questionRepository);

  Future<void> addQuestion(Question question) async {
    await _questionRepository.addQuestion(question);
  }

  Future<void> updateQuestion(Question question) async {
    await _questionRepository.updateQuestion(question);
  }

  Future<void> deleteQuestion(String questionId) async {
    await _questionRepository.deleteQuestion(questionId);
  }

  Future<List<Question>> getQuestions() async {
    return await _questionRepository.getQuestions();
  }

  Future<Question?> getQuestionById(String questionId) async {
    return await _questionRepository.getQuestionById(questionId);
  }
}
