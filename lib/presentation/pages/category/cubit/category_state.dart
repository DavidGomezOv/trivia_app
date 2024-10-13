part of 'category_cubit.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState({
    required List<CategoryUiModel> categories,
    CategoryUiModel? hoveredCategory,
    CategoryUiModel? selectedCategory,
  }) = _CategoryState;
}
