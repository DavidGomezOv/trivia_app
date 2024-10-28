import 'dart:convert';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivia_app/core/enums.dart';
import 'package:trivia_app/domain/irepositories/i_game_repository.dart';
import 'package:trivia_app/domain/models/difficulty_ui_model.dart';
import 'package:trivia_app/domain/models/game_config.dart';
import 'package:trivia_app/domain/models/question.dart';

part 'game_state.dart';

part 'game_cubit.freezed.dart';

enum GameStatus { initial, correctAnswer, incorrectAnswer, gameEnded }

class GameCubit extends Cubit<GameState> {
  GameCubit({required this.questionsRepository}) : super(const GameState());

  final IGameRepository questionsRepository;

  void resetGame() {
    emit(const GameState());
  }

  Future<void> getQuestions({required GameConfig gameConfig}) async {
    emit(state.copyWith(pageStatus: PageStatus.loading));

    final result = await questionsRepository.getQuestions(gameConfig: gameConfig);

    result.when(
      success: (data) {
        final decodedData = data.map(
          (question) {
            final decodedQuestion = Question(
              question: utf8.decode(base64.decode(question.question)),
              correctAnswer: utf8.decode(base64.decode(question.correctAnswer)),
              incorrectAnswers: question.incorrectAnswers
                  .map(
                    (answer) => utf8.decode(base64.decode(answer)),
                  )
                  .toList(),
            );
            final randomPositions = List<int>.generate(4, (i) => i)
              ..shuffle()
              ..shuffle();
            final index = Random().nextInt(randomPositions.length);
            List<String> displayAnswers = List.from(decodedQuestion.incorrectAnswers)
              ..insert(randomPositions[index], decodedQuestion.correctAnswer);
            return decodedQuestion.copyWith(displayAnswers: displayAnswers);
          },
        ).toList();
        emit(state.copyWith(questions: decodedData, pageStatus: PageStatus.loaded));
      },
      failure: (error) {
        emit(state.copyWith(pageStatus: PageStatus.failedToLoad, errorMessage: error.toString()));
      },
    );
  }

  void validateSelectedQuestion({required String selectedAnswer}) {
    final currentQuestionCorrectAnswer =
        state.questions[state.currentQuestion].correctAnswer.trim().toLowerCase();
    final bool isCorrectAnswer =
        selectedAnswer.trim().toLowerCase() == currentQuestionCorrectAnswer;
    GameState stateToEmit = state.copyWith(
      gameStatus: isCorrectAnswer ? GameStatus.correctAnswer : GameStatus.incorrectAnswer,
      correctAnswers: isCorrectAnswer ? state.correctAnswers + 1 : state.correctAnswers,
    );
    emit(stateToEmit);
  }

  void resetGameStatus() {
    emit(state.copyWith(gameStatus: GameStatus.initial));
  }

  void nextQuestion() {
    if (state.currentQuestion + 1 < state.questions.length) {
      emit(state.copyWith(currentQuestion: state.currentQuestion + 1));
    } else {
      emit(state.copyWith(gameStatus: GameStatus.gameEnded));
    }
  }

  void updateSelectedDifficulty({required DifficultyUiModel difficultyUiModel}) {
    emit(state.copyWith(selectedDifficulty: difficultyUiModel));
  }
}
