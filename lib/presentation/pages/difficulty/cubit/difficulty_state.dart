part of 'difficulty_cubit.dart';

@freezed
class DifficultyState with _$DifficultyState {
  const factory DifficultyState({
    required List<DifficultyUiModel> difficulties,
    DifficultyUiModel? selectedDifficulty,
    @Default(PageStatus.initial) PageStatus pageStatus,
    String? errorMessage,
  }) = _DifficultyState;
}
