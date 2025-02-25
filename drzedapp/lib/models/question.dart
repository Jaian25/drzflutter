abstract class Question {
  final String id;
  final String text;

  Question({required this.id, required this.text});

  Map<String, dynamic> toMap();
}

class TextQuestion extends Question {
  TextQuestion({required super.id, required super.text});

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'text': text, 'type': 'text'};
  }
}

class SingleChoiceQuestion extends Question {
  final List<String> options;

  SingleChoiceQuestion({
    required super.id,
    required super.text,
    required this.options,
  });

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'text': text, 'options': options, 'type': 'single_choice'};
  }
}

class MultipleChoiceQuestion extends Question {
  final List<String> options;

  MultipleChoiceQuestion({
    required super.id,
    required super.text,
    required this.options,
  });

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'text': text, 'options': options, 'type': 'multiple_choice'};
  }
}
