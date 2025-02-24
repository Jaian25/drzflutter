import 'package:firebase_database/firebase_database.dart';

class Test {
  String id;
  String iconUri;
  String title;
  String description;
  List<int> questionaries;

  Test({
    required this.id,
    required this.iconUri,
    required this.title,
    required this.description,
    required this.questionaries,
  });

  // Factory method to create an instance from Firebase Realtime Database snapshot
  factory Test.fromRealtimeDatabase(DataSnapshot snapshot) {
    Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value as Map);
    return Test(
      id: snapshot.key ?? '',
      iconUri: data['icon_uri'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      questionaries: List<int>.from(data['questionaries'] ?? []),
    );
  }

  // Convert the object to a map for storing in Firebase Realtime Database
  Map<String, dynamic> toMap() {
    return {
      'icon_uri': iconUri,
      'title': title,
      'description': description,
      'questionaries': questionaries,
    };
  }
}
