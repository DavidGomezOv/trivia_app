import 'dart:convert';

import 'package:trivia_app/data/base/base_json_parser.dart';

class DefaultJsonParser<T> extends BaseJsonParser<T> {
  final T Function(Map<String, dynamic>) fromJson;
  final String jsonKeyName;

  DefaultJsonParser({
    required this.fromJson,
    required this.jsonKeyName,
  });

  @override
  T parseFromJson(String json) => fromJson(jsonDecode(json)[jsonKeyName] as Map<String, dynamic>);
}
