import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivia_app/core/enums.dart';
import 'package:trivia_app/domain/irepositories/i_game_repository.dart';
import 'package:trivia_app/domain/models/game_config.dart';
import 'package:trivia_app/domain/models/question.dart';

part 'game_state.dart';

part 'game_cubit.freezed.dart';

enum GameStatus { initial, inProgress, finished }

class GameCubit extends Cubit<GameState> {
  GameCubit({required this.questionsRepository}) : super(const GameState());

  final IGameRepository questionsRepository;

  void resetGame(){
    emit(const GameState());
  }

  Future<void> getQuestions({required GameConfig gameConfig}) async {
    emit(state.copyWith(pageStatus: PageStatus.loading));

    final result = await questionsRepository.getQuestions(gameConfig: gameConfig);

    result.when(
      success: (data) {
        final decodedData = data
            .map(
              (question) => Question(
                question: utf8.decode(base64.decode(question.question)),
                correctAnswer: utf8.decode(base64.decode(question.correctAnswer)),
                incorrectAnswers: question.incorrectAnswers
                    .map(
                      (answer) => utf8.decode(base64.decode(answer)),
                    )
                    .toList(),
              ),
            )
            .toList();
        emit(state.copyWith(questions: decodedData, pageStatus: PageStatus.loaded));
      },
      failure: (error) {
        emit(state.copyWith(pageStatus: PageStatus.failedToLoad, errorMessage: error.toString()));
      },
    );
  }

  void nextQuestion() {
    emit(state.copyWith(currentQuestion: state.currentQuestion + 1));
  }
}
