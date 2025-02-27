import 'package:drzedapp/data/repository/test_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../models/question.dart';
import '../../models/test.dart';
import '../repository/question_repository.dart';

class FirebaseDbClient implements QuestionRepository, TestRepository {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  // Add Question
  @override
  Future<void> addQuestion(Question question) async {
    try {
      debugPrint("Question add ${question.id}");
      DatabaseReference questionRef = _database.ref('questions').child(question.id);
      debugPrint("Got reference");
      await questionRef.set(question.toMap());
      debugPrint("Question add done");
    } 
    catch (e) {
      throw Exception("Error adding question: $e");
    }
  }

  // Update Question
  @override
  Future<void> updateQuestion(Question question) async {
    try {
      DatabaseReference questionRef = _database.ref('questions').child(question.id);
      await questionRef.update(question.toMap());
    } catch (e) {
      throw Exception("Error updating question: $e");
    }
  }

  // Delete Question
  @override
  Future<void> deleteQuestion(String questionId) async {
    try {
      DatabaseReference questionRef = _database.ref('questions').child(questionId);
      await questionRef.remove();
    } catch (e) {
      throw Exception("Error deleting question: $e");
    }
  }

  // Get all Questions
  @override
  Future<List<Question>> getQuestions() async {
    try {
      DatabaseReference questionsRef = _database.ref('questions');
      DataSnapshot snapshot = await questionsRef.get();

      if (snapshot.exists && snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> questionsData = snapshot.value as Map<dynamic, dynamic>;

        return questionsData.entries.map((entry) {
          var data = Map<String, dynamic>.from(entry.value as Map);
          switch (data['type']) {
            case 'text':
              return TextQuestion(id: entry.key, text: data['text']);
            case 'single_choice':
              return SingleChoiceQuestion(
                id: entry.key,
                text: data['text'],
                options: List<String>.from(data['options'] ?? []),
              );
            case 'multiple_choice':
              return MultipleChoiceQuestion(
                id: entry.key,
                text: data['text'],
                options: List<String>.from(data['options'] ?? []),
              );
            default:
              throw Exception('Unknown question type: ${data['type']}');
          }
        }).toList();
      } else {
        debugPrint("[LOG] No questions found in database.");
        return [];
      }
    } catch (e) {
      debugPrint("[LOG] Error fetching questions: $e");
      throw Exception("Error fetching questions: $e");
    }
  }

  // Get a Question by ID
  @override
  Future<Question?> getQuestionById(String questionId) async {
    try {
      DatabaseReference questionRef = _database.ref('questions').child(questionId);
      DataSnapshot snapshot = await questionRef.get();

      if (snapshot.exists && snapshot.value is Map) {
        var data = Map<String, dynamic>.from(snapshot.value as Map);
        switch (data['type']) {
          case 'text':
            return TextQuestion(id: questionId, text: data['text']);
          case 'single_choice':
            return SingleChoiceQuestion(
              id: questionId,
              text: data['text'],
              options: List<String>.from(data['options'] ?? []),
            );
          case 'multiple_choice':
            return MultipleChoiceQuestion(
              id: questionId,
              text: data['text'],
              options: List<String>.from(data['options'] ?? []),
            );
          default:
            throw Exception('Unknown question type: ${data['type']}');
        }
      } else {
        debugPrint("[LOG] No question found for ID: $questionId");
        return null;
      }
    } catch (e) {
      debugPrint("[LOG] Error fetching question by ID: $e");
      throw Exception("Error fetching question by ID: $e");
    }
  }

  // Add Test
  @override
  Future<void> addTest(Test test) async {
    try {
      DatabaseReference testRef = _database.ref('tests').child(test.id);
      await testRef.set(test.toMap());
    } catch (e) {
      throw Exception("Error adding test: $e");
    }
  }

  // Update Test
  @override
  Future<void> updateTest(Test test) async {
    try {
      DatabaseReference testRef = _database.ref('tests').child(test.id);
      await testRef.update(test.toMap());
    } catch (e) {
      throw Exception("Error updating test: $e");
    }
  }

  // Delete Test
  @override
  Future<void> deleteTest(String testId) async {
    try {
      DatabaseReference testRef = _database.ref('tests').child(testId);
      await testRef.remove();
    } catch (e) {
      throw Exception("Error deleting test: $e");
    }
  }

  // Get a Test by ID
  @override
  Future<Test?> getTestById(String testId) async {
    try {
      DatabaseReference testRef = _database.ref('tests').child(testId);
      DataSnapshot snapshot = await testRef.get();

      if (snapshot.exists) {
        // Ensure Test.fromMap is called properly
        var data = Map<String, dynamic>.from(snapshot.value as Map);
        return Test.fromMap(data, testId); // Use fromMap with data and testId
      }
      return null;
    } catch (e) {
      throw Exception("Error fetching test by ID: $e");
    }
  }

  // Add Question to Test (Add question ID to the list)
  @override
  Future<void> addQuestionToTest(String testId, String questionId) async {
    try {
      DatabaseReference testRef = _database.ref('tests').child(testId);
      DataSnapshot snapshot = await testRef.get();

      if (snapshot.exists) {
        var data = Map<String, dynamic>.from(snapshot.value as Map);
        Test test = Test.fromMap(data, testId); // Properly convert snapshot to Test
        test.addQuestion(questionId); // Modify the test by adding the question ID
        await testRef.update(test.toMap()); // Update the test in the database
      } else {
        throw Exception("Test not found");
      }
    } catch (e) {
      throw Exception("Error adding question to test: $e");
    }
  }

  // Remove Question from Test (Remove question ID from the list)
  @override
  Future<void> removeQuestionFromTest(String testId, String questionId) async {
    try {
      DatabaseReference testRef = _database.ref('tests').child(testId);
      DataSnapshot snapshot = await testRef.get();

      if (snapshot.exists) {
        var data = Map<String, dynamic>.from(snapshot.value as Map);
        Test test = Test.fromMap(data, testId); // Properly convert snapshot to Test
        test.removeQuestion(questionId); // Modify the test by removing the question ID
        await testRef.update(test.toMap()); // Update the test in the database
      } else {
        throw Exception("Test not found");
      }
    } catch (e) {
      throw Exception("Error removing question from test: $e");
    }
  }

  // Get all Tests
  @override
  Future<List<Test>> getTests() async {
    try {
      DatabaseReference testsRef = _database.ref('tests');
      DataSnapshot snapshot = await testsRef.get();

      if (snapshot.exists && snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> testsData = snapshot.value as Map<dynamic, dynamic>;

        return testsData.entries.map((entry) {
          var data = Map<String, dynamic>.from(entry.value as Map);
          return Test.fromMap(data, entry.key); // Properly create Test object
        }).toList();
      } else {
        debugPrint("[LOG] No tests found in database.");
        return [];
      }
    } catch (e) {
      debugPrint("[LOG] Error fetching tests: $e");
      throw Exception("Error fetching tests: $e");
    }
  }
}
