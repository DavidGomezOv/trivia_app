part of 'game_cubit.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default(PageState.initial) PageState pageStatus,
  }) = _GameState;
}
