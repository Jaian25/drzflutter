import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../models/question.dart';
import '../repository/question_repository.dart';

class FirebaseDbClient implements QuestionRepository {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  // Add Question
  @override
  Future<void> addQuestion(Question question) async {
    try {
      DatabaseReference questionRef = _database.ref('questions').child(question.id);
      await questionRef.set(question.toMap());
    } catch (e) {
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

      if (snapshot.exists) {
        Map<dynamic, dynamic> questionsData = snapshot.value as Map<dynamic, dynamic>;

        return questionsData.entries.map((entry) {
          var data = entry.value as Map<String, dynamic>;
          switch (data['type']) {
            case 'text':
              return TextQuestion(id: entry.key, text: data['text']);
            case 'single_choice':
              return SingleChoiceQuestion(
                id: entry.key,
                text: data['text'],
                options: List<String>.from(data['options']),
              );
            case 'multiple_choice':
              return MultipleChoiceQuestion(
                id: entry.key,
                text: data['text'],
                options: List<String>.from(data['options']),
              );
            default:
              throw Exception('Unknown question type');
          }
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error fetching questions: $e");
    }
  }

  // Get a Question by ID
  @override
  Future<Question?> getQuestionById(String questionId) async {
    try {
      DatabaseReference questionRef = _database.ref('questions').child(questionId);
      DataSnapshot snapshot = await questionRef.get();

      if (snapshot.exists) {
        var data = snapshot.value as Map<String, dynamic>;
        switch (data['type']) {
          case 'text':
            return TextQuestion(id: questionId, text: data['text']);
          case 'single_choice':
            return SingleChoiceQuestion(
              id: questionId,
              text: data['text'],
              options: List<String>.from(data['options']),
            );
          case 'multiple_choice':
            return MultipleChoiceQuestion(
              id: questionId,
              text: data['text'],
              options: List<String>.from(data['options']),
            );
          default:
            throw Exception('Unknown question type');
        }
      }
      return null;
    } catch (e) {
      throw Exception("Error fetching question by ID: $e");
    }
  }
}
