import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivia_app/domain/models/ui_models/category_ui_model.dart';

part 'category_state.dart';

part 'category_cubit.freezed.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit()
      : super(
          CategoryState(
            categories: [
              CategoryUiModel(
                title: 'Sports',
                description: 'This is a small description of the selected category',
                angle: 3,
                color: Colors.red,
                hovered: false,
                mobileIcon: const Positioned(
                  bottom: (320 / 3) - 60,
                  child: MouseRegion(
                    opaque: false,
                    child: Icon(Icons.sports_soccer_outlined, size: 60, color: Colors.white),
                  ),
                ),
                webIcon: const Positioned(
                  bottom: (450 / 3) - 100,
                  child: MouseRegion(
                    opaque: false,
                    child: Icon(Icons.sports_soccer_outlined, size: 80, color: Colors.white),
                  ),
                ),
              ),
              CategoryUiModel(
                title: 'Movies',
                description: 'This is a small description of the selected category',
                angle: 1.5,
                color: Colors.yellow,
                hovered: false,
                mobileIcon: const Positioned(
                  bottom: (320 / 3) - 25,
                  left: (320 / 3) - 60,
                  child: MouseRegion(
                    opaque: false,
                    child: Icon(Icons.movie_outlined, size: 60, color: Colors.white),
                  ),
                ),
                webIcon: const Positioned(
                  bottom: (450 / 3) - 40,
                  left: (450 / 3) - 100,
                  child: MouseRegion(
                    opaque: false,
                    child: Icon(Icons.movie_outlined, size: 80, color: Colors.white),
                  ),
                ),
              ),
              CategoryUiModel(
                title: 'Science',
                description: 'This is a small description of the selected category',
                angle: 1,
                color: Colors.green,
                hovered: false,
                mobileIcon: const Positioned(
                  top: (320 / 3) - 25,
                  left: (320 / 3) - 60,
                  child: MouseRegion(
                    opaque: false,
                    child: Icon(Icons.science_outlined, size: 60, color: Colors.white),
                  ),
                ),
                webIcon: const Positioned(
                  top: (450 / 3) - 40,
                  left: (450 / 3) - 100,
                  child: MouseRegion(
                    opaque: false,
                    child: Icon(Icons.science_outlined, size: 80, color: Colors.white),
                  ),
                ),
              ),
              CategoryUiModel(
                title: 'History',
                description: 'This is a small description of the selected category',
                angle: -1.5,
                color: Colors.teal,
                hovered: false,
                mobileIcon: const Positioned(
                  top: (320 / 3) - 60,
                  child: MouseRegion(
                    opaque: false,
                    child: Icon(Icons.history_edu_outlined, size: 60, color: Colors.white),
                  ),
                ),
                webIcon: const Positioned(
                  top: (450 / 3) - 100,
                  child: MouseRegion(
                    opaque: false,
                    child: Icon(Icons.history_edu_outlined, size: 80, color: Colors.white),
                  ),
                ),
              ),
              CategoryUiModel(
                title: 'Geography',
                description: 'This is a small description of the selected category',
                angle: -3,
                color: Colors.blue,
                hovered: false,
                mobileIcon: const Positioned(
                  top: (320 / 3) - 25,
                  right: (320 / 3) - 60,
                  child: MouseRegion(
                    opaque: false,
                    child: Icon(Icons.map_outlined, size: 60, color: Colors.white),
                  ),
                ),
                webIcon: const Positioned(
                  top: (450 / 3) - 40,
                  right: (450 / 3) - 100,
                  child: MouseRegion(
                    opaque: false,
                    child: Icon(Icons.map_outlined, size: 80, color: Colors.white),
                  ),
                ),
              ),
              CategoryUiModel(
                title: 'Computers',
                description: 'This is a small description of the selected category',
                angle: -.5,
                color: Colors.deepPurple,
                hovered: false,
                mobileIcon: const Positioned(
                  bottom: (320 / 3) - 25,
                  right: (320 / 3) - 60,
                  child: MouseRegion(
                    opaque: false,
                    child: Icon(Icons.laptop_mac_outlined, size: 60, color: Colors.white),
                  ),
                ),
                webIcon: const Positioned(
                  bottom: (450 / 3) - 40,
                  right: (450 / 3) - 100,
                  child: MouseRegion(
                    opaque: false,
                    child: Icon(Icons.laptop_mac_outlined, size: 80, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );

  void updateCategoryHovered({required CategoryUiModel categoryHovered, bool hovered = true}) {
    for (var element in state.categories) {
      if (element.title == categoryHovered.title) {
        emit(state.copyWith(hoveredCategory: hovered ? element : null));
      }
    }
  }

  void updateSelectedCategory({required CategoryUiModel selectedCategory}) {
    emit(state.copyWith(selectedCategory: selectedCategory));
  }
}
