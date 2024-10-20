import 'package:trivia_app/core/result.dart';
import 'package:trivia_app/domain/models/game_config.dart';
import 'package:trivia_app/domain/models/question.dart';

abstract class IQuestionsRepository {
  Future<Result<List<Question>>> getQuestions({required GameConfig gameConfig});
}
