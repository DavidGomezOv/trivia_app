import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trivia_app/theme/custom_colors.dart';

class GameTimerController {
  GameTimerController();

  _GameTimerWidgetState? _state;

  int get secondsElapsed {
    assert(_state != null);
    return _state!._seconds;
  }

  int get minutesElapsed {
    assert(_state != null);
    return _state!._minutes;
  }

  void pauseTimer() {
    assert(_state != null);
    _state!.pauseTimer();
  }

  void resumeTimer() {
    assert(_state != null);
    _state!.startTimer();
  }
}

class GameTimerWidget extends StatefulWidget {
  const GameTimerWidget({
    super.key,
    this.controller,
  });

  final GameTimerController? controller;

  @override
  State<GameTimerWidget> createState() => _GameTimerWidgetState();
}

class _GameTimerWidgetState extends State<GameTimerWidget> {
  late GameTimerController _timerController;

  Timer? timer;
  int _minutes = 0;
  int _seconds = 0;

  void pauseTimer() {
    timer?.cancel();
  }

  void startTimer() {
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
  }

  @override
  void initState() {
    assert(widget.controller?._state == null);
    _timerController = widget.controller ?? GameTimerController();
    _timerController._state = this;
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timerController._state = null;
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer_rounded, color: CustomColors.greenText),
        const SizedBox(width: 4),
        Text(
          '${_minutes.toString().padLeft(2, '0')} : ${_seconds.toString().padLeft(2, '0')}',
          style: Theme.of(context).textTheme.titleSmall!,
        ),
      ],
    );
  }
}
