import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/presentation/pages/game/cubit/game_cubit.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class TimeIndicatorWidget extends StatefulWidget {
  const TimeIndicatorWidget({
    super.key,
    required this.maxTime,
    required this.timeOff,
  });

  final int maxTime;
  final Function() timeOff;

  @override
  State<TimeIndicatorWidget> createState() => _TimeIndicatorWidgetState();
}

class _TimeIndicatorWidgetState extends State<TimeIndicatorWidget> with TickerProviderStateMixin {
  final duration = {
    20: 2500,
    15: 2000,
    10: 1600,
  };

  late AnimationController controllerColor;
  late AnimationController controllerShake;
  late Animation<Color?> colorAnimation;
  late Timer timer;

  double shakes = 1;

  void _controllerListener() {
    if (!controllerColor.isAnimating) {
      _cancelWithoutDispose();
      widget.timeOff();
    }
  }

  void _init() {
    shakes = 1;
    controllerShake = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration[widget.maxTime] ?? 1500),
    )..forward();
    controllerColor = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.maxTime),
    );
    controllerColor
      ..forward(from: 1)
      ..reverse();
    timer = Timer.periodic(
      Duration(milliseconds: duration[widget.maxTime] ?? 1500),
      (timer) {
        shakes += 1;
        controllerShake
          ..reset()
          ..forward();
      },
    );
    controllerColor.addListener(_controllerListener);
    colorAnimation = controllerColor.drive(
      ColorTween(
        begin: Colors.red,
        end: CustomColors.greenText,
      ),
    );
  }

  void _cancelWithoutDispose() {
    controllerColor.removeListener(_controllerListener);
    controllerColor
      ..stop()
      ..reset();
    controllerShake
      ..stop()
      ..reset();
    timer.cancel();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    controllerColor.removeListener(_controllerListener);
    controllerColor.dispose();
    controllerShake.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameCubit, GameState>(
      listenWhen: (previous, current) => previous.currentQuestion != current.currentQuestion,
      listener: (context, state) {
        _cancelWithoutDispose();
        _init();
      },
      child: AnimatedBuilder(
        animation: controllerShake,
        builder: (BuildContext context, Widget? child) {
          final sineValue = sin(shakes * 2 * pi * controllerShake.value);
          return AnimatedContainer(
            duration: Duration(milliseconds: widget.maxTime),
            curve: Curves.easeInBack,
            child: Transform.translate(
              offset: Offset(sineValue * 8, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white38,
                  borderRadius: BorderRadius.circular(20),
                  minHeight: 20,
                  value: controllerColor.value,
                  valueColor: colorAnimation,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
