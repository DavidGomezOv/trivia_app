import 'dart:async';

import 'package:trivia_app/data/base/base_api_client.dart';
import 'package:trivia_app/data/default_json_parser.dart';
import 'package:trivia_app/data/list_json_parser.dart';
import 'package:trivia_app/domain/models/game_config.dart';
import 'package:trivia_app/domain/models/question.dart';
import 'package:trivia_app/domain/models/questions_per_difficulty.dart';

class GameApi {
  static const String baseUrl = 'opentdb.com';
  final BaseApiClient baseApiClient;

  GameApi(this.baseApiClient);

  Future<List<Question>> getQuestions({required GameConfig gameConfig}) async {
    final url = Uri.https(baseUrl, '/api.php', gameConfig.toJson());

    return await baseApiClient.invokeGet(
      path: url,
      jsonParser: ListJsonParser(
        fromJson: Question.fromJsonModel,
        jsonKeyName: 'results',
      ),
    );
  }

  Future<QuestionsPerDifficulty> getQuestionCountPerDifficulty({
    required String categoryId,
  }) async {
    final url = Uri.https(baseUrl, '/api_count.php', {'category': categoryId});

    return await baseApiClient.invokeGet(
      path: url,
      jsonParser: DefaultJsonParser(
        fromJson: QuestionsPerDifficulty.fromJsonModel,
        jsonKeyName: 'category_question_count',
      ),
    );
  }
}
