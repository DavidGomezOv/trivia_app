import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/core/enums.dart';
import 'package:trivia_app/core/extensions.dart';
import 'package:trivia_app/presentation/pages/game/cubit/game_cubit.dart';
import 'package:trivia_app/presentation/pages/game/widgets/answers_list_widget.dart';
import 'package:trivia_app/presentation/pages/game/widgets/game_header_widget.dart';
import 'package:trivia_app/presentation/pages/game/widgets/game_results_widget.dart';
import 'package:trivia_app/presentation/pages/game/widgets/game_timer_widget.dart';
import 'package:trivia_app/presentation/pages/game/widgets/selected_question_result_widget.dart';
import 'package:trivia_app/presentation/pages/game/widgets/time_left_indicator_widget.dart';
import 'package:trivia_app/presentation/widgets/base_scaffold.dart';
import 'package:trivia_app/presentation/widgets/error_state_widget.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final OverlayPortalController overlayPortalController = OverlayPortalController();
  final GameTimerController gameTimerController = GameTimerController();
  final ConfettiController confettiController =
      ConfettiController(duration: const Duration(seconds: 1));

  int _getParticlesBasedOnResult(int correctAnswers, int totalQuestions) =>
      (correctAnswers * 2) ~/ totalQuestions;

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = GoRouterState.of(context).uri.queryParameters['category']!;
    final gameCubit = context.read<GameCubit>();

    return BlocConsumer<GameCubit, GameState>(
      listenWhen: (previous, current) =>
          previous.pageStatus != current.pageStatus || previous.gameStatus != current.gameStatus,
      listener: (context, state) {
        if (state.pageStatus == PageStatus.failedToLoad) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.white24,
                content: Text(
                  state.errorMessage ?? 'An error occurred, please try again.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            );
        }
        if (state.gameStatus == GameStatus.correctAnswer ||
            state.gameStatus == GameStatus.incorrectAnswer) {
          overlayPortalController.toggle();
          gameTimerController.pauseTimer();
          Timer(
            const Duration(seconds: 2),
            () {
              gameTimerController.resumeTimer();
              overlayPortalController.toggle();
              context.read<GameCubit>()
                ..resetGameStatus()
                ..nextQuestion();
            },
          );
        }
        if (state.gameStatus == GameStatus.gameEnded) {
          confettiController.play();
        }
      },
      builder: (context, state) {
        final isGameEnded = state.gameStatus == GameStatus.gameEnded;
        return Stack(
          children: [
            BaseScaffold(
              width: context.isMobile() ? null : MediaQuery.sizeOf(context).width * 0.8,
              header: GameHeaderWidget(
                title: isGameEnded ? 'Results' : category,
                gameTimerController: isGameEnded ? null : gameTimerController,
                questionsIndicator:
                    isGameEnded ? null : '${state.currentQuestion + 1} / ${state.questions.length}',
              ),
              child: Builder(
                builder: (context) {
                  if (state.pageStatus == PageStatus.failedToLoad) {
                    return ErrorStateWidget(errorMessage: state.errorMessage);
                  }
                  if (isGameEnded) {
                    return GameResultsWidget(
                      correctAnswers: state.correctAnswers,
                      totalQuestions: state.questions.length,
                    );
                  }
                  if (state.pageStatus == PageStatus.loaded &&
                      state.questions.isNotEmpty &&
                      state.selectedDifficulty != null) {
                    final currentQuestionData = state.questions[state.currentQuestion];
                    return OverlayPortal(
                      controller: overlayPortalController,
                      overlayChildBuilder: (BuildContext context) => SelectedQuestionResultWidget(
                        isCorrect: state.gameStatus == GameStatus.correctAnswer,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (!context.isMobile()) const SizedBox(height: 20),
                          TimeLeftIndicatorWidget(
                            maxTime: state.selectedDifficulty!.timePerQuestion,
                            timeOff: () {
                              gameCubit.validateSelectedQuestion(selectedAnswer: '');
                            },
                          ),
                          const SizedBox(height: 20),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: '${state.currentQuestion + 1}. ',
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: CustomColors.greenText,
                                    fontSize: 21,
                                  ),
                              children: [
                                TextSpan(
                                  text: currentQuestionData.question,
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    fontVariations: [const FontVariation('wght', 500)],
                                    fontSize: 21,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: AnswersListWidget(
                                answers: currentQuestionData.displayAnswers,
                                correctAnswer: currentQuestionData.correctAnswer,
                                buttonColors: [
                                  Colors.red,
                                  Colors.blue,
                                  Colors.orange,
                                  Colors.teal,
                                ]..shuffle(),
                                onPressed: (selectedAnswer) {
                                  gameCubit.validateSelectedQuestion(
                                    selectedAnswer: selectedAnswer,
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            if (isGameEnded) ...[
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  gravity: .6,
                  numberOfParticles:
                      _getParticlesBasedOnResult(state.correctAnswers, state.questions.length),
                  emissionFrequency: 1,
                  minimumSize: const Size(30, 20),
                  maximumSize: const Size(40, 25),
                ),
              ),
              if (context.isMobile()) ...[
                Align(
                  alignment: Alignment.topRight,
                  child: ConfettiWidget(
                    confettiController: confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    gravity: .6,
                    numberOfParticles:
                        _getParticlesBasedOnResult(state.correctAnswers, state.questions.length),
                    emissionFrequency: 1,
                    minimumSize: const Size(30, 20),
                    maximumSize: const Size(40, 25),
                    particleDrag: .02,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: ConfettiWidget(
                    confettiController: confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    gravity: .6,
                    numberOfParticles:
                        _getParticlesBasedOnResult(state.correctAnswers, state.questions.length),
                    emissionFrequency: 1,
                    minimumSize: const Size(30, 20),
                    maximumSize: const Size(40, 25),
                    blastDirection: 0,
                    particleDrag: .02,
                  ),
                ),
              ],
            ],
          ],
        );
      },
    );
  }
}
