import 'dart:convert';

import 'package:trivia_app/data/base/base_json_parser.dart';

class ListJsonParser<T> extends BaseJsonParser<List<T>> {
  final T Function(Map<String, dynamic>) fromJson;
  final String jsonKeyName;

  ListJsonParser({
    required this.fromJson,
    required this.jsonKeyName,
  });

  @override
  List<T> parseFromJson(String json) {
    final decodedJson = jsonDecode(json)[jsonKeyName] as List<dynamic>;
    return decodedJson
        .map(
          (element) => fromJson(element as Map<String, dynamic>),
        )
        .toList();
  }
}
