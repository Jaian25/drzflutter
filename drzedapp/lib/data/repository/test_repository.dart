import '../../models/test.dart';

abstract class TestRepository {
  Future<void> addTest(Test test);
  Future<void> updateTest(Test test);
  Future<void> deleteTest(String testId);
  Future<Test?> getTestById(String testId);
  Future<void> addQuestionToTest(String testId, String questionId);
  Future<void> removeQuestionFromTest(String testId, String questionId);
}
