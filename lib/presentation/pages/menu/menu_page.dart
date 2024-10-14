import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/presentation/widgets/app_background_widget.dart';
import 'package:trivia_app/routes/app_router.dart';
import 'package:trivia_app/theme/button_styles.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: AppBackgroundWidget(
        child: Stack(
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
              painter: _MenuWavesBackground(fillColor: CustomColors.surfaceSecondary),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height / 2.5,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Transform.rotate(
                              angle: -pi / 4,
                              origin: const Offset(-1, 50),
                              child: Icon(
                                Icons.question_mark_sharp,
                                size: 120,
                                color: CustomColors.greenText.withOpacity(.3),
                              ),
                            ),
                            Icon(
                              Icons.question_mark_sharp,
                              size: 120,
                              color: CustomColors.greenText.withOpacity(.6),
                            ),
                            Transform.rotate(
                              angle: pi / 4,
                              origin: const Offset(-1, 50),
                              child: Icon(
                                Icons.question_mark_sharp,
                                size: 120,
                                color: CustomColors.greenText,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'TRIVIAPP',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: CustomColors.greenText),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'Let\'s Play!',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 10),
                Text(
                  'Play now and level up',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                ElevatedButton(
                  style: ButtonStyles.primaryButton(context),
                  onPressed: () => context.goNamed(AppRouter.categoryRouteData.name),
                  child: Text(
                    'Play Now',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuWavesBackground extends CustomPainter {
  _MenuWavesBackground({required this.fillColor});

  final Color fillColor;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height / 2.5)
      ..cubicTo(
        size.width / 5,
        size.height / 2.1,
        size.width / 3.5,
        size.height / 3,
        size.width / 2,
        size.height / 2.5,
      )
      ..cubicTo(
        size.width / 1.5,
        size.height / 2.3,
        size.width / 1.5,
        size.height / 2.8,
        size.width / 1.08,
        size.height / 2.4,
      )
      ..conicTo(
        size.width / 1.002,
        size.height / 2.3,
        size.width,
        size.height / 2.5,
        .5,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, Paint()..color = fillColor);
    canvas.restore();
    canvas.save();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
