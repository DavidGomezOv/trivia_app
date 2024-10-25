import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';

@freezed
class Question with _$Question {
  const factory Question({
    @Default('') String question,
    @Default('') String correctAnswer,
    @Default([]) List<String> incorrectAnswers,
    @Default([]) List<String> displayAnswers,
  }) = _Question;

  factory Question.fromJsonModel(Map<String, dynamic> json) => Question(
        question: json['question'],
        correctAnswer: json['correct_answer'],
        incorrectAnswers: (json['incorrect_answers'] as List<dynamic>)
            .map(
              (element) => element as String,
            )
            .toList(),
      );
}
