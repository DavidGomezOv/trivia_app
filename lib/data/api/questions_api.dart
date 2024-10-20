import 'dart:async';

import 'package:trivia_app/data/base_api_client.dart';
import 'package:trivia_app/data/list_json_parser.dart';
import 'package:trivia_app/domain/models/game_config.dart';
import 'package:trivia_app/domain/models/question.dart';

class QuestionsApi {
  static const String baseUrl = 'opentdb.com';
  final BaseApiClient baseApiClient;

  QuestionsApi(this.baseApiClient);

  Future<List<Question>> getQuestions({required GameConfig gameConfig}) async {
    final url = Uri.https(baseUrl, '/api.php', gameConfig.toJson());

    return await baseApiClient.invokeGet(
      path: url,
      jsonParser: ListJsonParser(fromJson: Question.fromJsonModel),
    );
  }
}
