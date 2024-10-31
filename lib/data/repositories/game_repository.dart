import 'dart:async';

import 'package:trivia_app/core/exceptions.dart';
import 'package:trivia_app/core/result.dart';
import 'package:trivia_app/data/api/game_api.dart';
import 'package:trivia_app/domain/irepositories/i_game_repository.dart';
import 'package:trivia_app/domain/models/game_config.dart';
import 'package:trivia_app/domain/models/question.dart';
import 'package:trivia_app/domain/models/questions_per_difficulty.dart';

class GameRepository implements IGameRepository {
  final GameApi questionsApi;

  GameRepository({required this.questionsApi});

  @override
  Future<Result<List<Question>>> getQuestions({required GameConfig gameConfig}) =>
      _captureErrorsOnApiCall<List<Question>>(
        apiCall: questionsApi.getQuestions(gameConfig: gameConfig),
      );

  @override
  Future<Result<QuestionsPerDifficulty>> getQuestionCountPerDifficulty({
    required String categoryId,
  }) =>
      _captureErrorsOnApiCall<QuestionsPerDifficulty>(
        apiCall: questionsApi.getQuestionCountPerDifficulty(categoryId: categoryId),
      );

  @override
  Future<Result<String>> getSessionToken() => _captureErrorsOnApiCall<String>(
        apiCall: questionsApi.getSessionToken(),
      );

  Future<Result<T>> _captureErrorsOnApiCall<T>({required Future<T> apiCall}) async {
    try {
      final result = await apiCall;
      return Result.success(data: result);
    } on NetworkException catch (error) {
      return Result.failure(error: error);
    } on Exception catch (error) {
      return Result.failure(error: error);
    }
  }
}
