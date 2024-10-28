import 'package:trivia_app/core/result.dart';
import 'package:trivia_app/domain/models/game_config.dart';
import 'package:trivia_app/domain/models/question.dart';
import 'package:trivia_app/domain/models/questions_per_difficulty.dart';

abstract class IGameRepository {
  Future<Result<List<Question>>> getQuestions({required GameConfig gameConfig});

  Future<Result<QuestionsPerDifficulty>> getQuestionCountPerDifficulty({
    required String categoryId,
  });

  Future<Result<String>> getSessionToken();
}
