import 'dart:convert';

import 'package:trivia_app/data/base/base_json_parser.dart';

class SessionTokenJsonParser<T> extends BaseJsonParser<T> {
  final String jsonKeyName;

  SessionTokenJsonParser({
    required this.jsonKeyName,
  });

  @override
  T parseFromJson(String json) => jsonDecode(json)[jsonKeyName];
}
