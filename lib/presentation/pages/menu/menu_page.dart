import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/presentation/pages/menu/widgets/header_icons_widget.dart';
import 'package:trivia_app/presentation/pages/menu/widgets/title_widget.dart';
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
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
              painter: _MenuWavesBackground(fillColor: CustomColors.surfaceSecondary),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height / 2.5,
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          HeaderIconsWidget(),
                          SizedBox(height: 30),
                          TitleWidget(),
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
                    'Test your knowledge and have fun',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
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
