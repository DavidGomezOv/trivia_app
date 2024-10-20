import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/domain/models/game_config.dart';
import 'package:trivia_app/core/extensions.dart';
import 'package:trivia_app/presentation/pages/difficulty/cubit/difficulty_cubit.dart';
import 'package:trivia_app/presentation/pages/difficulty/widgets/difficulty_button_widget.dart';
import 'package:trivia_app/presentation/pages/game/cubit/game_cubit.dart';
import 'package:trivia_app/presentation/widgets/base_scaffold.dart';
import 'package:trivia_app/routes/app_router.dart';
import 'package:trivia_app/theme/button_styles.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class DifficultyPage extends StatelessWidget {
  const DifficultyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DifficultyCubit>(
      create: (context) => DifficultyCubit(),
      child: BaseScaffold(
        backButton: Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(top: 20, left: 10, bottom: context.isMobile() ? 30 : 0),
          child: ElevatedButton(
            style: ButtonStyles.primaryButton(context)
                .copyWith(padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
            onPressed: () => context.goNamed(AppRouter.categoryRouteData.name),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: BlocBuilder<DifficultyCubit, DifficultyState>(
                builder: (context, state) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: state.difficulties
                            .map(
                              (element) => DifficultyButtonWidget(
                                difficulty: element,
                                isSelected: element == state.selectedDifficulty,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      state.selectedDifficulty?.title ?? 'Select Difficulty',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: state.selectedDifficulty == null
                                ? Colors.white
                                : CustomColors.greenText,
                            fontSize: state.selectedDifficulty == null ? 38 : 46,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      state.selectedDifficulty?.description ??
                          'Click on any difficulty section to continue.',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    if (state.selectedDifficulty != null)
                      ElevatedButton(
                        style: ButtonStyles.primaryButton(context),
                        onPressed: () {
                          final gameConfig = GameConfig(
                            amount: state.selectedDifficulty!.questionsQuantity.toString(),
                            category: GoRouterState.of(context)
                                .uri
                                .queryParameters['category']!
                                .categoryId(),
                            difficulty: state.selectedDifficulty!.title.toLowerCase(),
                          );
                          context.read<GameCubit>()
                            ..resetGame()
                            ..getQuestions(gameConfig: gameConfig);
                          context.goNamed(AppRouter.gameRouteData.name);
                        },
                        child: Text(
                          'Start Game',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
