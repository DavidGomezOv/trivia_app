import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/core/extensions.dart';
import 'package:trivia_app/presentation/pages/game/cubit/game_cubit.dart';
import 'package:trivia_app/theme/button_styles.dart';

class AnswersListWidget extends StatelessWidget {
  const AnswersListWidget({
    super.key,
    required this.answers,
    required this.correctAnswer,
    required this.buttonColors,
    required this.onPressed,
  });

  final List<String> answers;
  final String correctAnswer;
  final List<Color> buttonColors;
  final Function(String selectedAnswer) onPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      children: answers.mapIndexed(
        (index, element) {
          final color = buttonColors[index];
          return BlocBuilder<GameCubit, GameState>(
            buildWhen: (previous, current) => previous.gameStatus != current.gameStatus,
            builder: (context, state) {
              final isValidatingAnswer = state.gameStatus == GameStatus.incorrectAnswer ||
                  state.gameStatus == GameStatus.correctAnswer;
              return Container(
                width: 450,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ElevatedButton(
                  style: ButtonStyles.primaryButton(context).copyWith(
                    backgroundColor: isValidatingAnswer
                        ? WidgetStatePropertyAll(
                            element == correctAnswer ? Colors.green : Colors.red,
                          )
                        : WidgetStateProperty.resolveWith(
                            (states) => states.contains(WidgetState.hovered)
                                ? color.withOpacity(.8)
                                : color,
                          ),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(context.isMobile() ? 20 : 34)),
                  ),
                  onPressed: isValidatingAnswer ? null : () => onPressed.call(element),
                  child: Text(
                    element,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontVariations: [const FontVariation('wght', 500)],
                      fontSize: 19,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }
}
