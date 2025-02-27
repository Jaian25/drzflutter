import 'package:firebase_database/firebase_database.dart';

class Test {
  String id;
  String iconUri;
  String title;
  String description;
  List<String> questionariesId;

  Test({
    required this.id,
    required this.iconUri,
    required this.title,
    required this.description,
    required this.questionariesId,
  });

  // Factory method to create an instance from Firebase Realtime Database snapshot
  factory Test.fromMap(Map<String, dynamic> data, String id) {
    return Test(
      id: id,
      iconUri: data['icon_uri'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      questionariesId: List<String>.from(data['questionariesId'] ?? []),
    );
  }

  // Convert the object to a map for storing in Firebase Realtime Database
  Map<String, dynamic> toMap() {
    return {
      'icon_uri': iconUri,
      'title': title,
      'description': description,
      'questionariesId': questionariesId,
    };
  }

  // Add a question ID to the Test
  void addQuestion(String questionId) {
    if (!questionariesId.contains(questionId)) {
      questionariesId.add(questionId);
    }
  }

  // Remove a question ID from the Test
  void removeQuestion(String questionId) {
    questionariesId.remove(questionId);
  }
}
