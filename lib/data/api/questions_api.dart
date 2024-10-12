import 'dart:async';

import 'package:trivia_app/data/base_api_client.dart';
import 'package:trivia_app/data/list_json_parser.dart';
import 'package:trivia_app/domain/models/question.dart';

class QuestionsApi {
  static const String baseUrl = 'https://opentdb.com';
  final BaseApiClient baseApiClient;

  QuestionsApi(this.baseApiClient);

  Future<List<Question>> getQuestions() async {
    final queryParams = {'amount': 10};
    final url = Uri.http(baseUrl, 'api.php', queryParams);

    return await baseApiClient.invokeGet(
      path: url,
      jsonParser: ListJsonParser(fromJson: Question.fromJson),
    );
  }
}
