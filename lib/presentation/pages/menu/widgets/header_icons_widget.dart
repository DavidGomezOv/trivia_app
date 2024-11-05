import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class HeaderIconsWidget extends StatefulWidget {
  const HeaderIconsWidget({super.key});

  @override
  State<HeaderIconsWidget> createState() => _HeaderIconsWidgetState();
}

class _HeaderIconsWidgetState extends State<HeaderIconsWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> opacity1;
  late Animation<double> opacity2;
  late Animation<double> opacity3;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    animation1 = Tween<double>(
      begin: -1.5,
      end: -.8,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.35,
          curve: Curves.easeInOutBack,
        ),
      ),
    );

    animation2 = Tween<double>(
      begin: -.9,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.3,
          0.7,
          curve: Curves.easeInOutBack,
        ),
      ),
    );

    animation3 = Tween<double>(
      begin: 0,
      end: .8,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.65,
          1.0,
          curve: Curves.easeInOutBack,
        ),
      ),
    );

    opacity1 = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0,
          0.35,
          curve: Curves.easeIn,
        ),
      ),
    );

    opacity2 = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.3,
          0.7,
          curve: Curves.easeIn,
        ),
      ),
    );

    opacity3 = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.65,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: animation1,
          builder: (context, child) {
            return Opacity(
              opacity: opacity1.value,
              child: Transform.rotate(
                angle: animation1.value * (pi / 2.5),
                origin: const Offset(-1, 50),
                child: Icon(
                  Icons.question_mark_sharp,
                  size: 120,
                  color: CustomColors.greenText.withOpacity(.3),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: animation2,
          builder: (context, child) {
            return Opacity(
              opacity: opacity2.value,
              child: Transform.rotate(
                angle: animation2.value * (pi / 2.5),
                origin: const Offset(0, 50),
                child: Icon(
                  Icons.question_mark_sharp,
                  size: 120,
                  color: CustomColors.greenText.withOpacity(.6),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: animation3,
          builder: (context, child) {
            return Opacity(
              opacity: opacity3.value,
              child: Transform.rotate(
                angle: animation3.value * (pi / 2.5),
                origin: const Offset(1, 50),
                child: Icon(
                  Icons.question_mark_sharp,
                  size: 120,
                  color: CustomColors.greenText,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
