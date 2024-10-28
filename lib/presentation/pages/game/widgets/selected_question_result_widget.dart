import 'package:flutter/material.dart';

class SelectedQuestionResultWidget extends StatelessWidget {
  const SelectedQuestionResultWidget({
    super.key,
    required this.isCorrect,
  });

  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        height: 200,
        color: isCorrect ? Colors.green : Colors.red,
        alignment: Alignment.center,
        child: Text(
          isCorrect ? 'Correct!' : 'Oops, incorrect!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
