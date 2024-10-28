import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/core/extensions.dart';
import 'package:trivia_app/routes/app_router.dart';
import 'package:trivia_app/theme/button_styles.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class GameResultsWidget extends StatelessWidget {
  const GameResultsWidget({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  final int correctAnswers;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    final value = ((correctAnswers * 100) / totalQuestions) / 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: CustomColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  height: double.infinity,
                  child: FittedBox(
                    fit: context.isMobile() ? BoxFit.fitWidth : BoxFit.fitHeight,
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: value),
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastOutSlowIn,
                      builder: (context, value, child) {
                        return CircularProgressIndicator(
                          strokeWidth: 2,
                          value: value,
                          color: CustomColors.greenText,
                          backgroundColor: Colors.white38,
                          strokeCap: StrokeCap.round,
                        );
                      },
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your final score is',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: CustomColors.greenText,
                          ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: correctAnswers.toString(),
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: CustomColors.greenText,
                              fontSize: 70,
                            ),
                        children: [
                          TextSpan(
                            text: ' / $totalQuestions',
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 30,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: 250,
          child: ElevatedButton(
            style: ButtonStyles.primaryButton(context),
            onPressed: () => context.goNamed(AppRouter.categoryRouteData.name),
            child: Text(
              'Try Again',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 150,
          child: ElevatedButton(
            style: ButtonStyles.primaryButton(context),
            onPressed: () => context.goNamed(AppRouter.menuRouteData.name),
            child: Text(
              'Exit',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
