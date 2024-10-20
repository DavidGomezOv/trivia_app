import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_config.freezed.dart';

part 'game_config.g.dart';

@freezed
class GameConfig with _$GameConfig {
  const factory GameConfig({
    required String amount,
    required String category,
    required String difficulty,
    @Default('multiple') String type,
    @Default('base64') String encode,
  }) = _GameConfig;

  factory GameConfig.fromJson(Map<String, dynamic> json) => _$GameConfigFromJson(json);
}
