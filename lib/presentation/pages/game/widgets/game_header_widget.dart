import 'package:flutter/material.dart';
import 'package:trivia_app/presentation/pages/game/widgets/game_timer_widget.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class GameHeaderWidget extends StatelessWidget {
  const GameHeaderWidget({
    super.key,
    required this.title,
    this.gameTimerController,
    this.questionsIndicator,
  });

  final String title;
  final GameTimerController? gameTimerController;
  final String? questionsIndicator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            title,
            style:
                Theme.of(context).textTheme.displaySmall!.copyWith(color: CustomColors.greenText),
          ),
        ),
        if (gameTimerController != null && questionsIndicator != null)
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GameTimerWidget(controller: gameTimerController),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  questionsIndicator!,
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
