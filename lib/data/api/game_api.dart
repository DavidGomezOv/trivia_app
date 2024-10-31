import 'dart:async';

import 'package:trivia_app/data/base/base_api_client.dart';
import 'package:trivia_app/data/default_json_parser.dart';
import 'package:trivia_app/data/list_json_parser.dart';
import 'package:trivia_app/data/session_token_json_parser.dart';
import 'package:trivia_app/domain/models/game_config.dart';
import 'package:trivia_app/domain/models/question.dart';
import 'package:trivia_app/domain/models/questions_per_difficulty.dart';

class GameApi {
  static const String baseUrl = 'opentdb.com';
  final BaseApiClient baseApiClient;

  GameApi(this.baseApiClient);

  Future<String> getSessionToken() async {
    final url = Uri.https(
      baseUrl,
      '/api_token.php',
      {'command': 'request'},
    );

    return await baseApiClient.invokeGet<String>(
      path: url,
      jsonParser: SessionTokenJsonParser<String>(jsonKeyName: 'token'),
    );
  }

  Future<List<Question>> getQuestions({required GameConfig gameConfig}) async {
    final url = Uri.https(
      baseUrl,
      '/api.php',
      {...gameConfig.toJson(), 'token': ''},
    );

    return await baseApiClient.invokeGet<List<Question>>(
      path: url,
      jsonParser: ListJsonParser<Question>(
        fromJson: Question.fromJsonModel,
        jsonKeyName: 'results',
      ),
    );
  }

  Future<QuestionsPerDifficulty> getQuestionCountPerDifficulty({
    required String categoryId,
  }) async {
    final url = Uri.https(baseUrl, '/api_count.php', {'category': categoryId});

    return await baseApiClient.invokeGet<QuestionsPerDifficulty>(
      path: url,
      jsonParser: DefaultJsonParser<QuestionsPerDifficulty>(
        fromJson: QuestionsPerDifficulty.fromJsonModel,
        jsonKeyName: 'category_question_count',
      ),
    );
  }
}
