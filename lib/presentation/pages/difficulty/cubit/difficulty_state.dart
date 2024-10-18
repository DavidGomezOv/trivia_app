part of 'difficulty_cubit.dart';

@freezed
class DifficultyState with _$DifficultyState {
  const factory DifficultyState({
    required List<DifficultyUiModel> difficulties,
    DifficultyUiModel? selectedDifficulty,
  }) = _DifficultyState;
}
