import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/core/extensions.dart';
import 'package:trivia_app/presentation/pages/game/cubit/game_cubit.dart';
import 'package:trivia_app/presentation/widgets/base_scaffold.dart';
import 'package:trivia_app/routes/app_router.dart';
import 'package:trivia_app/theme/button_styles.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      width: context.isMobile() ? null : MediaQuery.sizeOf(context).width * 0.8,
      backButton: Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.only(top: 20, left: 10, bottom: context.isMobile() ? 30 : 0),
        child: ElevatedButton(
          style: ButtonStyles.primaryButton(context)
              .copyWith(padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
          onPressed: () => context.goNamed(AppRouter.menuRouteData.name),
          child: const Icon(
            Icons.home_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      child: BlocConsumer<GameCubit, GameState>(
        listenWhen: (previous, current) => previous.pageStatus != current.pageStatus,
        listener: (context, state) {
          if (state.pageStatus == PageState.failedToLoad) {
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
          if (state.pageStatus == PageState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.pageStatus == PageState.failedToLoad) {
            return Center(
              child: Text(
                state.errorMessage ?? 'An error occurred, please try again.',
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            );
          }
          if (state.pageStatus == PageState.loaded && state.questions.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _ProgressIndicator(
                  currentQuestion: state.currentQuestion,
                  maxQuestions: state.questions.length,
                ),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '${state.currentQuestion + 1}. ',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: CustomColors.greenText),
                    children: [
                      TextSpan(
                        text: state.questions[state.currentQuestion].question,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyles.primaryButton(context),
                  onPressed: () => context.read<GameCubit>().nextQuestion(),
                  child: Text(
                    'Next Question',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({
    required this.currentQuestion,
    required this.maxQuestions,
  });

  final int currentQuestion;
  final int maxQuestions;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.blueGrey,
      color: CustomColors.greenText,
      borderRadius: BorderRadius.circular(20),
      minHeight: 20,
      value: (currentQuestion + 1) / maxQuestions,
    );
  }
}
