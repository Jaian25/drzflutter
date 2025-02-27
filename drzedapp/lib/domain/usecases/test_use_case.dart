import '../../data/repository/test_repository.dart';
import '../../models/test.dart';

class TestUseCase {
  final TestRepository _testRepository;

  TestUseCase(this._testRepository);

  Future<void> addTest(Test test) async {
    await _testRepository.addTest(test);
  }

  Future<void> updateTest(Test test) async {
    await _testRepository.updateTest(test);
  }

  Future<void> deleteTest(String testId) async {
    await _testRepository.deleteTest(testId);
  }

  Future<Test?> getTestById(String testId) async {
    return await _testRepository.getTestById(testId);
  }

  Future<List<Test>> getTests() async {
    return await _testRepository.getTests();
  }

  Future<void> addQuestionToTest(String testId, String questionId) async {
    await _testRepository.addQuestionToTest(testId, questionId);
  }

  Future<void> removeQuestionFromTest(String testId, String questionId) async {
    await _testRepository.removeQuestionFromTest(testId, questionId);
  }
}
