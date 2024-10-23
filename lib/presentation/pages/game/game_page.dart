import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/core/enums.dart';
import 'package:trivia_app/core/extensions.dart';
import 'package:trivia_app/presentation/pages/game/cubit/game_cubit.dart';
import 'package:trivia_app/presentation/pages/game/widgets/time_indicator_widget.dart';
import 'package:trivia_app/presentation/widgets/base_scaffold.dart';
import 'package:trivia_app/presentation/widgets/error_state_widget.dart';
import 'package:trivia_app/theme/button_styles.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final category = GoRouterState.of(context).uri.queryParameters['category']!;
    final gameCubit = context.read<GameCubit>();
    return BlocConsumer<GameCubit, GameState>(
      listenWhen: (previous, current) => previous.pageStatus != current.pageStatus,
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
      },
      builder: (context, state) {
        return BaseScaffold(
          width: context.isMobile() ? null : MediaQuery.sizeOf(context).width * 0.8,
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  category,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: CustomColors.greenText),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  '${state.currentQuestion + 1} / ${state.questions.length}',
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
            ],
          ),
          child: Builder(
            builder: (context) {
              if (state.pageStatus == PageStatus.failedToLoad) {
                return ErrorStateWidget(errorMessage: state.errorMessage);
              }
              if (state.pageStatus == PageStatus.loaded &&
                  state.questions.isNotEmpty &&
                  state.selectedDifficulty != null) {
                final currentQuestionData = state.questions[state.currentQuestion];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (!context.isMobile()) const SizedBox(height: 20),
                    TimeIndicatorWidget(
                      maxTime: state.selectedDifficulty!.timePerQuestion,
                      timeOff: () {
                        gameCubit.nextQuestion();
                      },
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: '${state.currentQuestion + 1}. ',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: CustomColors.greenText,
                              fontSize: 22,
                            ),
                        children: [
                          TextSpan(
                            text: currentQuestionData.question,
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontVariations: [const FontVariation('wght', 500)],
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: currentQuestionData.incorrectAnswers
                            .map(
                              (element) => ElevatedButton(
                                style: ButtonStyles.primaryButton(context),
                                onPressed: () => gameCubit.nextQuestion(),
                                child: Text(
                                  element,
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyles.primaryButton(context),
                      onPressed: () => gameCubit.nextQuestion(),
                      child: Text(
                        'Next Question',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }
}
