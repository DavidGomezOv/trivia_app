import 'package:trivia_app/data/base/base_json_parser.dart';

abstract class BaseApiClient {
  Future<T> invokeGet<T>({
    required Uri path,
    Map<String, dynamic>? headerParams,
    Map<String, dynamic>? queryParams,
    required BaseJsonParser<T> jsonParser,
  });
}
