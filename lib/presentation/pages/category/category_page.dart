import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/extensions.dart';
import 'package:trivia_app/presentation/widgets/app_background_widget.dart';
import 'package:trivia_app/routes/app_router.dart';
import 'package:trivia_app/theme/button_styles.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  static const List<double> buttonAngles = [3, 1.5, 1, -1.5, -3, -.5];

  static const List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blueAccent,
    Colors.purple,
  ];

  static const List<Widget> webButtonIcons = [
    Positioned(
        bottom: (450 / 3) - 100,
        child: MouseRegion(
          opaque: false,
          child: Icon(
            Icons.sports_esports_rounded,
            size: 80,
            color: Colors.white,
          ),
        )),
    Positioned(
        bottom: (450 / 3) - 40,
        left: (450 / 3) - 100,
        child: MouseRegion(
          opaque: false,
          child: Icon(
            Icons.sports_esports_rounded,
            size: 80,
            color: Colors.white,
          ),
        )),
    Positioned(
        top: (450 / 3) - 40,
        left: (450 / 3) - 100,
        child: MouseRegion(
          opaque: false,
          child: Icon(
            Icons.sports_esports_rounded,
            size: 80,
            color: Colors.white,
          ),
        )),
    Positioned(
        top: (450 / 3) - 100,
        child: MouseRegion(
          opaque: false,
          child: Icon(
            Icons.sports_esports_rounded,
            size: 80,
            color: Colors.white,
          ),
        )),
    Positioned(
        top: (450 / 3) - 40,
        right: (450 / 3) - 100,
        child: MouseRegion(
          opaque: false,
          child: Icon(
            Icons.sports_esports_rounded,
            size: 80,
            color: Colors.white,
          ),
        )),
    Positioned(
        bottom: (450 / 3) - 40,
        right: (450 / 3) - 100,
        child: MouseRegion(
          opaque: false,
          child: Icon(
            Icons.sports_esports_rounded,
            size: 80,
            color: Colors.white,
          ),
        )),
  ];

  static const List<Widget> mobileButtonIcons = [
    Positioned(
        bottom: (320 / 3) - 60,
        child: MouseRegion(
          opaque: false,
          child: Icon(
            Icons.sports_esports_rounded,
            size: 60,
            color: Colors.white,
          ),
        )),
    Positioned(
        bottom: (320 / 3) - 25,
        left: (320 / 3) - 60,
        child: MouseRegion(
          opaque: false,
          child: Icon(
            Icons.sports_esports_rounded,
            size: 60,
            color: Colors.white,
          ),
        )),
    Positioned(
        top: (320 / 3) - 25,
        left: (320 / 3) - 60,
        child: MouseRegion(
          opaque: false,
          child: Icon(
            Icons.sports_esports_rounded,
            size: 60,
            color: Colors.white,
          ),
        )),
    Positioned(
        top: (320 / 3) - 60,
        child: MouseRegion(
          opaque: false,
          child: Icon(
            Icons.sports_esports_rounded,
            size: 60,
            color: Colors.white,
          ),
        )),
    Positioned(
        top: (320 / 3) - 25,
        right: (320 / 3) - 60,
        child: MouseRegion(
          opaque: false,
          child: Icon(
            Icons.sports_esports_rounded,
            size: 60,
            color: Colors.white,
          ),
        )),
    Positioned(
        bottom: (320 / 3) - 25,
        right: (320 / 3) - 60,
        child: MouseRegion(
          opaque: false,
          child: Icon(
            Icons.sports_esports_rounded,
            size: 60,
            color: Colors.white,
          ),
        )),
  ];

  List<bool> hovered = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackgroundWidget(
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: SizedBox(
                width: 60,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyles.primaryButton(context)
                      .copyWith(padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
                  onPressed: () => context.goNamed(AppRouter.menuRouteData.name),
                  child: const Icon(Icons.home_rounded, color: Colors.white, size: 40),
                ),
              ),
            ),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ...List.generate(
                    6,
                    (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: context.isMobile() ? 320 : 450,
                        height: context.isMobile() ? 320 : 450,
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 200),
                          scale: hovered[index] ? 1.2 : 1,
                          child: ClipPath(
                            clipper: FirstButtonClipper(angle: buttonAngles[index]),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                MouseRegion(
                                  onEnter: (event) {
                                    setState(() {
                                      hovered[index] = true;
                                    });
                                  },
                                  onExit: (event) {
                                    setState(() {
                                      hovered[index] = false;
                                    });
                                  },
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () => print('BUTTON ${colors[index]}'),
                                    child: Container(color: colors[index]),
                                  ),
                                ),
                                context.isMobile()
                                    ? mobileButtonIcons[index]
                                    : webButtonIcons[index],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstButtonClipper extends CustomClipper<Path> {
  FirstButtonClipper({super.reclip, required this.angle});

  final double angle;

  @override
  Path getClip(Size size) {
    const double sweepAngle = pi / 3;
    double startAngle = pi / angle;

    Path path = Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..arcTo(
        Rect.fromLTWH(0, 0, size.width, size.height),
        startAngle,
        sweepAngle,
        true,
      )
      ..lineTo(size.width / 2, size.height / 2);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
