import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivia_app/domain/models/difficulty_ui_model.dart';

part 'difficulty_state.dart';

part 'difficulty_cubit.freezed.dart';

class DifficultyCubit extends Cubit<DifficultyState> {
  DifficultyCubit()
      : super(
          DifficultyState(
            difficulties: [
              DifficultyUiModel(
                title: 'Easy',
                description: 'You will have 20 seconds per question and a total of 10 questions.',
                questionsQuantity: 10,
                timePerQuestion: 20,
                backgroundColor: Colors.green,
                starts: 1,
              ),
              DifficultyUiModel(
                title: 'Medium',
                description: 'You will have 15 seconds per question and a total of 15 questions.',
                questionsQuantity: 15,
                timePerQuestion: 15,
                backgroundColor: Colors.orange,
                starts: 2,
              ),
              DifficultyUiModel(
                title: 'Hard',
                description: 'You will have 10 seconds per question and a total of 20 questions.',
                questionsQuantity: 20,
                timePerQuestion: 10,
                backgroundColor: Colors.red,
                starts: 3,
              ),
            ],
          ),
        );

  void updateSelectedDifficulty({required DifficultyUiModel selectedDifficulty}) {
    emit(state.copyWith(selectedDifficulty: selectedDifficulty));
  }
}
