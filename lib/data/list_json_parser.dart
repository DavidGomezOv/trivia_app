import 'dart:convert';

import 'package:trivia_app/data/base_json_parser.dart';

class ListJsonParser<T> extends BaseJsonParser<List<T>> {
  final T Function(Map<String, dynamic>) fromJson;

  ListJsonParser({required this.fromJson});

  @override
  List<T> parseFromJson(String json) {
    final decodedJson = jsonDecode(json)['results'] as List<dynamic>;
    return decodedJson
        .map(
          (element) => fromJson(element as Map<String, dynamic>),
        )
        .toList();
  }
}
