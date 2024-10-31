import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivia_app/core/enums.dart';
import 'package:trivia_app/domain/irepositories/i_game_repository.dart';
import 'package:collection/collection.dart';
import 'package:trivia_app/domain/models/ui_models/difficulty_ui_model.dart';

part 'difficulty_state.dart';

part 'difficulty_cubit.freezed.dart';

class DifficultyCubit extends Cubit<DifficultyState> {
  DifficultyCubit({required this.questionsRepository})
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

  final IGameRepository questionsRepository;

  Future<void> getQuestionCountPerDifficulty({required String categoryId}) async {
    emit(state.copyWith(pageStatus: PageStatus.loading));

    final result = await questionsRepository.getQuestionCountPerDifficulty(categoryId: categoryId);

    result.when(
      success: (data) {
        final List<int> questionsPerCategory = [
          data.easyQuestions,
          data.mediumQuestions,
          data.hardQuestions,
        ];
        final List<DifficultyUiModel> verifiedDifficulties = [];

        state.difficulties.forEachIndexed((index, element) {
          if (questionsPerCategory[index] >= element.questionsQuantity) {
            verifiedDifficulties.add(element);
          }
        });

        if (verifiedDifficulties.isEmpty) {
          emit(
            state.copyWith(
              pageStatus: PageStatus.failedToLoad,
              errorMessage:
                  'No questions available for the selected Category, please choose another one.',
            ),
          );
          return;
        }

        emit(state.copyWith(difficulties: verifiedDifficulties, pageStatus: PageStatus.loaded));
      },
      failure: (error) {
        emit(state.copyWith(pageStatus: PageStatus.failedToLoad, errorMessage: error.toString()));
      },
    );
  }

  void updateSelectedDifficulty({required DifficultyUiModel selectedDifficulty}) {
    emit(state.copyWith(selectedDifficulty: selectedDifficulty));
  }
}
