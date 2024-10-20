import 'package:freezed_annotation/freezed_annotation.dart';

part 'questions_per_difficulty.freezed.dart';

@freezed
class QuestionsPerDifficulty with _$QuestionsPerDifficulty {
  const factory QuestionsPerDifficulty({
    @Default(0) int easyQuestions,
    @Default(0) int mediumQuestions,
    @Default(0) int hardQuestions,
  }) = _QuestionsPerDifficulty;

  factory QuestionsPerDifficulty.fromJsonModel(Map<String, dynamic> json) => QuestionsPerDifficulty(
        easyQuestions: json['total_easy_question_count'] ?? 0,
        mediumQuestions: json['total_medium_question_count'] ?? 0,
        hardQuestions: json['total_hard_question_count'] ?? 0,
      );


}
