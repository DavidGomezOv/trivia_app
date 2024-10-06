import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';

part 'question.g.dart';

@freezed
class Question with _$Question {
  const factory Question({
    @Default('') String? type,
    @Default('') String? difficulty,
    @Default('') String? category,
    @Default('') String? question,
    @Default('') String? correctAnswer,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
