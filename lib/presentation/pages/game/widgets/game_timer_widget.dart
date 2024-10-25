import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class GameTimerWidget extends StatefulWidget {
  const GameTimerWidget({super.key});

  @override
  State<GameTimerWidget> createState() => _GameTimerWidgetState();
}

class _GameTimerWidgetState extends State<GameTimerWidget> {
  late final Timer timer;
  int _minutes = 0;
  int _seconds = 0;

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _seconds += 1;
        if (_seconds == 60) {
          _minutes += 1;
          _seconds = 0;
        }
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer_rounded, color: CustomColors.greenText),
        Text(
          '${_minutes.toString().padLeft(2, '0')} : ${_seconds.toString().padLeft(2, '0')}',
          style: Theme.of(context).textTheme.titleSmall!,
        ),
      ],
    );
  }
}
