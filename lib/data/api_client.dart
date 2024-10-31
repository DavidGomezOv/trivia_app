import 'dart:async';

import 'package:trivia_app/core/exceptions.dart';
import 'package:trivia_app/data/base/base_api_client.dart';
import 'package:trivia_app/data/base/base_json_parser.dart';
import 'package:http/http.dart' as http;

class ApiClient implements BaseApiClient {
  @override
  Future<T> invokeGet<T>({
    required Uri path,
    Map<String, dynamic>? headerParams,
    Map<String, dynamic>? queryParams,
    required BaseJsonParser<T> jsonParser,
  }) async {
    try {
      final response = await http.get(path).timeout(const Duration(seconds: 30));

      switch (response.statusCode) {
        case 200:
          return jsonParser.parseFromJson(response.body);
        default:
          throw ApiException(
            code: response.statusCode,
            message: response.reasonPhrase ?? '',
          );
      }
    } on TimeoutException catch (_) {
      throw NetworkException(message: 'Connection Timeout');
    } on http.ClientException catch (error) {
      throw Exception('Failed parsing json data: $error');
    }
  }
}
