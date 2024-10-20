part of 'game_cubit.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default([]) List<Question> questions,
    @Default(0) int currentQuestion,
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(GameStatus.initial) GameStatus gameStatus,
    String? errorMessage,
  }) = _GameState;
}
