import '../models/question.dart';

class QuestionBuilder {
  static Question build(Map<String, dynamic> data, String id) {
    String type = data['type'];

    switch (type) {
      case 'text':
        return TextQuestion(id: id, text: data['text']);
      case 'single_choice':
        return SingleChoiceQuestion(id: id, text: data['text'], options: List<String>.from(data['options']));
      case 'multiple_choice':
        return MultipleChoiceQuestion(id: id, text: data['text'], options: List<String>.from(data['options']));
      default:
        throw Exception("Unknown question type: $type");
    }
  }
}
