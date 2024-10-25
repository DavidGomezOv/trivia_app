import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/app.dart';
import 'package:trivia_app/core/extensions.dart';
import 'package:trivia_app/theme/button_styles.dart';

class AnswersListWidget extends StatelessWidget {
  const AnswersListWidget({
    super.key,
    required this.answers,
    required this.onPressed,
  });

  final List<String> answers;
  final Function(String selectedAnswer) onPressed;

  @override
  Widget build(BuildContext context) {
    List<Color> buttonColors = [Colors.red, Colors.blue, Colors.green, Colors.deepPurple]
      ..shuffle();
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      children: answers.mapIndexed(
        (index, element) {
          final color = buttonColors[index];
          return Container(
            width: 450,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ElevatedButton(
              style: ButtonStyles.primaryButton(context).copyWith(
                backgroundColor: WidgetStateProperty.resolveWith(
                  (states) => states.contains(WidgetState.hovered) ? color.withOpacity(.8) : color,
                ),
                padding: WidgetStatePropertyAll(EdgeInsets.all(context.isMobile() ? 20 : 34)),
              ),
              onPressed: () => onPressed.call(element),
              child: Text(
                element,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontVariations: [const FontVariation('wght', 500)],
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
